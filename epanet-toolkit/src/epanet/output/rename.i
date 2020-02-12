


// RENAME FUNCTIONS ACCORDING TO PEP8
%rename(create_handle)      ENR_createHandle;
%rename(delete_handle)      ENR_deleteHandle;
%rename(close_file)         ENR_closeFile;
%rename(open_file)          ENR_openFile;

%rename(get_version)        ENR_getVersion;
%rename(get_net_size)       ENR_getNetSize;
%rename(get_units)          ENR_getUnits;
%rename(get_times)          ENR_getTimes;
//%rename(get_chem_data)    ENR_getChemData;
%rename(get_elem_name)      ENR_getElementName;
%rename(get_energy_usage)   ENR_getEnergyUsage;
%rename(get_net_reacts)     ENR_getNetReacts;

%rename(get_node_series)    ENR_getNodeSeries;
%rename(get_link_series)    ENR_getLinkSeries;

%rename(get_node_attribute) ENR_getNodeAttribute;
%rename(get_link_attribute) ENR_getLinkAttribute;

%rename(get_node_result)    ENR_getNodeResult;
%rename(get_link_result)    ENR_getLinkResult;

%rename(output_free)        ENR_freeMemory;
%rename(clear_error)        ENR_clearError;
%rename(check_error)        ENR_checkError;
