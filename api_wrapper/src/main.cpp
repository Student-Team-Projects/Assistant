#include <iostream>
#include <string>
#include <list>
#include <memory>

#include "restc-cpp/restc-cpp.h"
#include "restc-cpp/RequestBuilder.h"

#include <nlohmann/json.hpp>

int main() {
	auto restClient = restc_cpp::RestClient::Create();

	nlohmann::json payload = {
		{"model", "llama3.2"},
		{"prompt", "Why is the sky blue"},
		{"stream", false}
	};

	restClient->Process([&](restc_cpp::Context& ctx) {
		std::cout << "Preparing..." << std::endl;

        // Construct a request to the server
        auto reply = restc_cpp::RequestBuilder(ctx)
			// For testing if this even works:
            // .Get("http://jsonplaceholder.typicode.com/posts/")
            // // Add some headers for good taste
            // .Header("X-Client", "RESTC_CPP")
            // .Header("X-Client-Purpose", "Testing")

			// Actualy testing with local connection:
            .Get("http://localhost:11434/api/tags")

			// What should be working but isn't - probably misformated request or sth:
            // .Get("http://localhost:11434/api/request")
			// .Data("{\"model\": \"llama3.2\", \"prompt\": \"Why is the sky blue?\", \"stream\": false}")
            .Execute();

		std::cout << "Reply: " << reply->GetBodyAsString() << std::endl;
    });

	std::cout << "Sent." << std::endl;

    // Wait for the request to finish
    restClient->CloseWhenReady(true);

	std::cout << "Exiting..." << std::endl;

	return 0;
}
