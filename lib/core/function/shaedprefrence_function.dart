import 'package:dreamjob/core/constants/string.dart';

import '../../features/company/data/Data_source/job_data_source.dart';
import '../../main.dart';

addCompanyDataToSharedprefrence() async {
  String id = await JobDataSource().getJobOwnerID();
  Map<String, dynamic> companydata = await JobDataSource()
      .getCompanyDetails(comp_id: id) as Map<String, dynamic>;
  sharedpref.setString(companyIdKey, id);
  sharedpref.setString(companyNameKey, companydata[jobOwnerUserName]);
  sharedpref.setString(companyemailKey, companydata[jobOwneremail]);
  sharedpref.setString(companyUrlKey, companydata[jobOwnerImage]);
}

addWorkerDataToSharedPrefrence() async {
  String id = await JobDataSource().getWorderID();
  Map workerData = await JobDataSource().getWorkerDetails(workerId: id)
      as Map<String, dynamic>;
  sharedpref.setString(workerIdKey, id);
  sharedpref.setString(workerNameKey, workerData[workerUserName]);
  sharedpref.setString(workerEmailKey, workerData[workerEmail]);
  sharedpref.setString(workerUrlKey, workerData[workerImage]);
}
