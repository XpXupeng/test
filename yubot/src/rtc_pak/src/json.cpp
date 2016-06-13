#include <iostream>
#include <string>
#include "../include/json/json.h"
using namespace std;

int main(void)
{
    Json::Value root;
    Json::FastWriter fast_writer;
    root["1111"] = "1234";
    std::string ret = root["1111"].asString();    
    root["REGION_ID:"] = "600901";
    root["DATA_TOTAL_NUM"] = "456278";

    std::cout << ret << std::endl;
    std::cout << fast_writer.write(root) << std::endl;

    return 0;

}
