function [CRCfault_status, MCfault_status] = CRCandMCchecker(message_CRC_is_OK, message_MC, config, reset) %#codegen
% Function for checking the mesage MC & CRC, and resolving a fault

persistent state
if isempty(state)
    state.MC_faults_counter = 0;
    state.CRC_faults_counter = 0;
    state.last_valid_MC_value = uint8(0);
end

if reset
    state.MC_faults_counter = 0;
    state.CRC_faults_counter = 0;
    state.last_valid_MC_value = uint8(0);
end


%% Latching
MCfault_status = def_FaultStatus.INIT;
CRCfault_status = def_FaultStatus.INIT;

if state.MC_faults_counter>config.max_MC_errors
    MCfault_status = def_FaultStatus.FATAL;
end
if state.CRC_faults_counter>config.max_CRC_errors
    CRCfault_status = def_FaultStatus.FATAL;
end




%% Calcs
state.last_valid_MC_value = mod(state.last_valid_MC_value+1,config.MC_size);

if message_CRC_is_OK && CRCfault_status ~= def_FaultStatus.FATAL
    state.CRC_faults_counter = 0;
    
    if message_MC == state.last_valid_MC_value && MCfault_status ~= def_FaultStatus.FATAL
        state.MC_faults_counter = 0;
    else
        state.MC_faults_counter = state.MC_faults_counter+1;
        state.last_valid_MC_value = message_MC;
    end
    
else
    state.CRC_faults_counter = state.CRC_faults_counter+1;
end


if state.MC_faults_counter == 0
    MCfault_status = def_FaultStatus.NoFault;
elseif state.MC_faults_counter <= config.max_MC_errors
    MCfault_status = def_FaultStatus.FaultActive;
else
    MCfault_status = def_FaultStatus.FATAL;
end

if state.CRC_faults_counter == 0
    CRCfault_status = def_FaultStatus.NoFault;
elseif state.CRC_faults_counter <= config.max_CRC_errors
    CRCfault_status = def_FaultStatus.FaultActive;
else
    CRCfault_status = def_FaultStatus.FATAL;
end



