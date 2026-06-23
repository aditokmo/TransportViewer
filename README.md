# TransportViewer
Simple report program for evaluating released transports

### Folder structure:



```text
Z_TRANSPORT_EVAL/                                  ABAP Package
│
├── 🔹 Dictionary/                                    DDIC objects (data elements, structures, tables)
│   │
│   ├── 🔹 Data Elements/
│   │   ├── ZTE_OWNER                                 Data element: Transport Owner
│   │   ├── ZTE_TR_TYPE                               Data element: Transport Type
│   │   ├── ZTE_DISP_STRAT                            Data element: Display Strategy
│   │   └── ZTE_MAX_TR                                Data element: Max Transport Number
│   │
│   ├── 🔹 Structures/
│   │   ├── ZTS_TRANSPORT                             Transport table single row output structure
│   │   └── ZTS_SEL_PARAMS                            Selection screen structure for user input
│   │
│   └── 🔹 Table Types/
│   |   └── ZTS_TRANSPORTS                            Transport Table Type structure
|   |
│   └── 🔹 Database Tables/
│       └── ZTR_CONFIG                                Database table configuration
│
└── 🔹 Source Library/                                Classes, interfaces and main view program
    │
    ├── 🔹 Interfaces/
    │   ├── ZIF_TR_DISPLAY                            Show data interface
    │   ├── ZIF_TR_DATA                               Get data interface
    │   └── ZIF_TR_CONFIG                             Read configuration data interface
    │
    ├── 🔹 Classes/
    │   ├── ZCL_TR_CONFIG_MANAGER                     Implementation of ZIF_TR_CONFIG
    │   ├── ZCL_TR_DATA_PROVIDER                      Implementation of ZIF_TR_DATA
    │   ├── ZCL_TR_DISPLAY_ALV_GRID                   Strategy 1: ALV Grid
    │   ├── ZCL_TR_DISPLAY_ALV_TABLE                  Strategy 2: ALV Classic Table
    │   ├── ZCL_TR_DISPLAY_FACTORY                    Display strategy
    │   └── ZCL_TR_CONTROLLER                         MVC Controller
    │
    └── 🔹 Programs/
        └── ZTR_TRANSPORT_EVAL                        Main report View/Frontend
