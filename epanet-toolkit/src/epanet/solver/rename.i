/*
 *  rename.i - SWIG interface description file for EPANET Solver API
 *
 *  Created:    2/12/2020
 *
 *  Author:     Michael E. Tryby
 *              US EPA - ORD/CESER
 *
*/


// RENAME FUNCTIONS ACCORDING TO PEP8
%rename(proj_create)              EN_createproject;
%rename(proj_delete)              EN_deleteproject;
%rename(proj_run)                 EN_runproject;
%rename(proj_init)                EN_init;
%rename(proj_open)                EN_open;
%rename(proj_get_title)           EN_gettitle;
%rename(proj_set_title)           EN_settitle;
%rename(proj_get_comment)         EN_getcomment;
%rename(proj_set_comment)         EN_setcomment;
%rename(proj_get_count)           EN_getcount;
%rename(proj_save_file)           EN_saveinpfile;
%rename(proj_close)               EN_close;

%rename(hydr_solve)               EN_solveH;
%rename(hydr_save)                EN_saveH;
%rename(hydr_open)                EN_openH;
%rename(hydr_init)                EN_initH;
%rename(hydr_run)                 EN_runH;
%rename(hydr_next)                EN_nextH;
%rename(hydr_close)               EN_closeH;
%rename(hydr_save_file)           EN_savehydfile;
%rename(hydr_use_file)            EN_usehydfile;

%rename(qual_solve)               EN_solveQ;
%rename(qual_open)                EN_openQ;
%rename(qual_init)                EN_initQ;
%rename(qual_run)                 EN_runQ;
%rename(qual_next)                EN_nextQ;
%rename(qual_step)                EN_stepQ;
%rename(qual_close)               EN_closeQ;

%rename(rprt_write_line)          EN_writeline;
%rename(rprt_write_results)       EN_report;
%rename(rprt_copy)                EN_copyreport;
%rename(rprt_clear)               EN_clearreport;
%rename(rprt_reset)               EN_resetreport;
%rename(rprt_set)                 EN_setreport;
%rename(rprt_set_level)           EN_setstatusreport;
%rename(rprt_anlys_stats)         EN_getstatistic;
%rename(rprt_get_result_index)    EN_getresultindex;

%rename(anlys_get_option)         EN_getoption;
%rename(anlys_set_option)         EN_setoption;
%rename(anlys_get_flow_units)     EN_getflowunits;
%rename(anlys_set_flow_units)     EN_setflowunits;
%rename(anlys_get_time_param)     EN_gettimeparam;
%rename(anlys_set_time_param)     EN_settimeparam;
%rename(anlys_get_qual_info)      EN_getqualinfo;
%rename(anlys_get_qual_type)      EN_getqualtype;
%rename(anlys_set_qual_type)      EN_setqualtype;

%rename(node_add)                 EN_addnode;
%rename(node_delete)              EN_deletenode;
%rename(node_get_index)           EN_getnodeindex;
%rename(node_get_id)              EN_getnodeid;
%rename(node_set_id)              EN_setnodeid;
%rename(node_get_type)            EN_getnodetype;
%rename(node_get_value)           EN_getnodevalue;
%rename(node_set_value)           EN_setnodevalue;
%rename(node_set_junc_data)       EN_setjuncdata;
%rename(node_set_tank_data)       EN_settankdata;
%rename(node_get_coord)           EN_getcoord;
%rename(node_set_coord)           EN_setcoord;

%rename(dmnd_get_model)           EN_getdemandmodel;
%rename(dmnd_set_model)           EN_setdemandmodel;
%rename(dmnd_add)                 EN_adddemand;
%rename(dmnd_delete)              EN_deletedemand;
%rename(demd_get_index)           EN_getdemandindex;
%rename(dmnd_get_count)           EN_getnumdemands;
%rename(dmnd_get_base)            EN_getbasedemand;
%rename(dmnd_set_base)            EN_setbasedemand;
%rename(dmnd_get_pattern)         EN_getdemandpattern;
%rename(dmnd_set_pattern)         EN_setdemandpattern;
%rename(dmnd_get_name)            EN_getdemandname;
%rename(dmnd_set_name)            EN_setdemandname;

%rename(link_add)                 EN_addlink;
%rename(link_delete)              EN_deletelink;
%rename(link_get_index)           EN_getlinkindex;
%rename(link_get_id)              EN_getlinkid;
%rename(link_set_id)              EN_setlinkid;
%rename(link_get_type)            EN_getlinktype;
%rename(link_set_type)            EN_setlinktype;
%rename(link_get_nodes)           EN_getlinknodes;
%rename(link_set_nodes)           EN_setlinknodes;
%rename(link_get_value)           EN_getlinkvalue;
%rename(link_set_value)           EN_setlinkvalue;
%rename(link_set_pipe_data)       EN_setpipedata;
%rename(link_get_vertex_count)    EN_getvertexcount;
%rename(link_get_vertex)          EN_getvertex;
%rename(link_set_vertices)        EN_setvertices;

%rename(pump_get_type)            EN_getpumptype;
%rename(pump_get_curve_index)     EN_getheadcurveindex;
%rename(pump_set_curve_index)     EN_setheadcurveindex;

%rename(ptrn_add)                 EN_addpattern;
%rename(ptrn_delete)              EN_deletepattern;
%rename(ptrn_get_index)           EN_getpatternindex;
%rename(ptrn_get_id)              EN_getpatternid;
%rename(ptrn_set_id)              EN_setpatternid;
%rename(ptrn_get_length)          EN_getpatternlen;
%rename(ptrn_get_value)           EN_getpatternvalue;
%rename(ptrn_set_value)           EN_setpatternvalue;
%rename(ptrn_get_avg_value)       EN_getaveragepatternvalue;
%rename(ptrn_set)                 EN_setpattern;

%rename(curv_add)                 EN_addcurve;
%rename(curv_delete)              EN_deletecurve;
%rename(curv_get_index)           EN_getcurveindex;
%rename(curv_get_id)              EN_getcurveid;
%rename(curve_set_id)             EN_setcurveid;
%rename(curv_get_length)          EN_getcurvelen;
%rename(curv_get_type)            EN_getcurvetype;
%rename(curv_get_value)           EN_getcurvevalue;
%rename(curv_set_value)           EN_setcurvevalue;
%rename(curv_get)                 EN_getcurve;
%rename(curv_set)                 EN_setcurve;

%rename(scntl_add)                EN_addcontrol;
%rename(scntl_delete)             EN_deletecontrol;
%rename(scntl_get)                EN_getcontrol;
%rename(scntl_set)                EN_setcontrol;

%rename(rcntl_add)                EN_addrule;
%rename(rcntl_delete)             EN_deleterule;
%rename(rcntl_get)                EN_getrule;
%rename(rcntl_get_id)             EN_getruleID;
%rename(rcntl_get_premise)        EN_getpremise;
%rename(rcntl_set_premise)        EN_setpremise;
%rename(rcntl_set_premise_index)  EN_setpremiseindex;
%rename(rcntl_set_premise_status) EN_setpremisestatus;
%rename(rcntl_set_premise_value)  EN_setpremisevalue;
%rename(rcntl_get_then_action)    EN_getthenaction;
%rename(rcntl_set_then_action)    EN_setthenaction;
%rename(rcntl_get_else_action)    EN_getelseaction;
%rename(rcntl_set_else_action)    EN_setelseaction;
%rename(rcntl_set_rule_priority)  EN_setrulepriority;

%rename(solver_get_error)         EN_getrerror;
%rename(solver_get_version)       EN_getversion;
