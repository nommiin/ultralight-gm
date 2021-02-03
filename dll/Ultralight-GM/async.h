#pragma once
#define GM_EXPORT extern "C" __declspec (dllexport)

const int EVENT_OTHER_SOCIAL = 70;
void (*CreateAsynEventWithDSMap)(int, int)=0;
int (*CreateDsMap)(int _num, ...)=0;
bool (*DsMapAddDouble)(int _index, char* _pKey, double value)=0;
bool (*DsMapAddString)(int _index, char* _pKey, char* pVal)=0;

GM_EXPORT void RegisterCallbacks(char* arg1, char* arg2, char* arg3, char* arg4) {
    void (*CreateAsynEventWithDSMapPtr)(int, int) = (void (*)(int, int))(arg1);
    int(*CreateDsMapPtr)(int _num, ...) = (int(*)(int _num, ...)) (arg2);
    CreateAsynEventWithDSMap = CreateAsynEventWithDSMapPtr;
    CreateDsMap = CreateDsMapPtr;

    bool (*DsMapAddDoublePtr)(int _index, char* _pKey, double value) = (bool(*)(int, char*, double))(arg3);
    bool (*DsMapAddStringPtr)(int _index, char* _pKey, char* pVal) = (bool(*)(int, char*, char*))(arg4);

    DsMapAddDouble = DsMapAddDoublePtr;
    DsMapAddString = DsMapAddStringPtr;
}

GM_EXPORT double CreateMap() {
    return (double)CreateDsMap(0);
}

GM_EXPORT double CallAsync(double _map) {
    CreateAsynEventWithDSMap(_map, EVENT_OTHER_SOCIAL);
    return 1;
}