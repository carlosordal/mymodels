function diagnosticRequest = generateDiagnosticRequest()
%GENERATEDIAGNOSTICREQUEST
%This function generate vectors for diagnostics request


msgTx100 = canMessage(100, false, 0);

diagnosticRequest = 0;
