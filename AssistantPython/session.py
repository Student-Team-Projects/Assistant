import os
import asyncio
from google.adk.sessions import InMemorySessionService
from google.adk.runners import Runner
from Assistant.agent import sigma_agent
from google.genai import types
from AgentSimple.agent_simple import agent2
import sys
import subprocess

import warnings

warnings.filterwarnings("ignore")

import logging

logging.basicConfig(level=logging.CRITICAL)

session_service = InMemorySessionService()

APP_NAME = "python_assistant"
USER_ID = "user_1"
SESSION_ID = "session_001"


async def init_session(app_name: str, user_id: str, session_id: str) -> InMemorySessionService:
    sesh = await session_service.create_session(
        app_name=app_name,
        user_id=user_id,
        session_id=session_id
    )
    logging.debug(f"Session created: App='{app_name}', User='{user_id}', Session='{session_id}'")
    return sesh


session = asyncio.run(init_session(APP_NAME, USER_ID, SESSION_ID))

runner = Runner(
    agent=sigma_agent,
    app_name=APP_NAME,
    session_service=session_service
)
logging.debug(f"Runner created for agent '{runner.agent.name}'.")


async def call_agent_async(query: str, runner, user_id, session_id) -> str:
    logging.debug(f"\n>>> User Query: {query}")
    content = types.Content(role='user', parts=[types.Part(text=query)])

    final_response_text = "Agent did not produce a final response."

    async for event in runner.run_async(user_id=user_id, session_id=session_id, new_message=content):
        if event.is_final_response():
            if event.content and event.content.parts:
                final_response_text = event.content.parts[0].text
                logging.debug(f"[Debug] Agent finished with: {final_response_text}")

            elif event.actions and event.actions.escalate:
                final_response_text = f"Agent escalated: {event.error_message or 'No message.'}"

    print(f"\nYour command is: {final_response_text}")

    return final_response_text


async def run_conversation(inp: str) -> str:

    x = await call_agent_async(inp,
                           runner=runner,
                           user_id=USER_ID,
                           session_id=SESSION_ID)

    return x


if __name__ == "__main__":
    prompt = " ".join(sys.argv[1:])
    try:
        response = asyncio.run(run_conversation(prompt))
        i = input(f"Run this command [y/n]")
        if i.lower() == 'y':
            subprocess.run(response, shell=True)
        else:
            sys.exit(0)

    except Exception as e:
        print(f"An error occurred: {e}")
