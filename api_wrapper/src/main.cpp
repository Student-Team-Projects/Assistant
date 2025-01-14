#include <iostream>
#include <fstream>
#include <string>
#include <list>
#include <memory>
#include <chrono>
#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>

#include "restc-cpp/restc-cpp.h"
#include "restc-cpp/RequestBuilder.h"

#include <nlohmann/json.hpp>

#include <boost/algorithm/string.hpp>

int main(int argc, char** argv) {

	nlohmann::json payload = {
		{"model", "llama3.2"},
		{"prompt", ""},
		{"stream", false}
	};

	struct passwd *pw = getpwuid(getuid());
	const char* homedir = pw->pw_dir;
	std::string rcFileName(homedir);
	rcFileName += "/.assistantRC";
	std::ifstream rcFile(rcFileName);
	std::string modelName;
	std::getline(rcFile, modelName);
	rcFile.close();
	boost::trim_right(modelName);

	payload["model"] = modelName;

	std::string question;

	if (argc > 1) {
		question.assign(argv[1]);
	} else {
		std::cin >> question;
	}

	if (question == "load_model") {
		question = "";
	} else {
		question = "Your job is to help with using linux. Answer only with a command without quotes. The question is: " + question;
	}

	payload["prompt"] = question;

	auto restClient = restc_cpp::RestClient::Create();

	auto reply = std::make_unique<std::string>();

	auto awaitResponse = restClient->ProcessWithPromise([&](restc_cpp::Context& ctx) {

        // Construct a request to the server
	    auto internalReply = restc_cpp::RequestBuilder(ctx)
			// For testing if this even works:
            // .Get("http://jsonplaceholder.typicode.com/posts/")
            // // Add some headers for good taste
            // .Header("X-Client", "RESTC_CPP")
            // .Header("X-Client-Purpose", "Testing")

			// Actualy testing with local connection:
            // .Get("http://localhost:11434/api/tags")

			// What should be working but isn't - probably misformated request or sth:
            .Post("http://localhost:11434/api/generate")
	    .Data(payload.dump(4))
	    // .Data("{\"model\": \"llama3.2\", \"prompt\": \"Why is the sky blue?\", \"stream\": false}")
            .Execute();

	    //std::cout << "Reply: " << internalReply->GetBodyAsString() << std::endl;
	    *reply = internalReply->GetBodyAsString();
    });

	try {
		awaitResponse.get();
	} catch (const std::exception& e) {
		std::cout << e.what() << std::endl;
	}

	if (question == "") {
		return 0;
	}

	nlohmann::json answer = nlohmann::json::parse(*reply);
	std::string model_response = answer.at("response");
	// model_response = model_response.substr(1, model_response.length()-2);
	std::cout << model_response << std::endl;
	// std::cerr << "Model response for debug: " << model_response << std::endl;

	return 0;
}
