#include <iostream>
#include <string>

using namespace std;

int main() {
    string user_input;

    cout << "Do you want to execute the command? [yes[Enter]/no]: ";
    getline(cin, user_input);

    if(user_input.empty()){
        cout<<"Command confirmed for execution." << endl;
        return 0;
    }

    for (auto &c : user_input) {
        c = tolower(c);
    }
    auto c = tolower(user_input[0]);
    if (c == 'y') {
        cout << "Command confirmed for execution." << endl;
        return 0;
    } else {
        cout << "Execution aborted." << endl;
        return 1;
    }
}
