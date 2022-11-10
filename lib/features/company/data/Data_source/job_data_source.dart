import 'dart:io';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamjob/core/constants/string.dart';
import 'package:dreamjob/features/company/data/models/jobModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class JobDataSource {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  getJobOwnerID() async {
    String? email = FirebaseAuth.instance.currentUser!.email;
    String id = '';
    QuerySnapshot jobOwnerSnap = await FirebaseFirestore.instance
        .collection(jobOwner)
        .where(jobOwneremail, isEqualTo: email)
        .get();
    jobOwnerSnap.docs.forEach((element) {
      var data = element.data() as Map<String, dynamic>;
      if (data[jobOwneremail] == email) id = element.id;
    });
    return id;
  }

  getWorderID() async {
    String? email = FirebaseAuth.instance.currentUser!.email;
    String id = '';
    QuerySnapshot workerSnap = await FirebaseFirestore.instance
        .collection(worker)
        .where(workerEmail, isEqualTo: email)
        .get();
    workerSnap.docs.forEach((element) {
      var data = element.data() as Map<String, dynamic>;
      if (data[workerEmail] == email) id = element.id;
    });
    return id;
  }

  //add Job
  addJob(
      {required String title,
      required double salary,
      required String description,
      required String address,
      required String type,
      required String category,
      required String closeCategory}) async {
    CollectionReference jobCollection = firebaseFirestore.collection('jobs');
    String id = await getJobOwnerID();
    await jobCollection.add({
      jobNumberOfOrder: 0,
      jobTitle: title,
      jobSalary: salary,
      jobDescription: description,
      jobAddress: address,
      jobType: type,
      jobcompanyId: id,
      jobcategory: category,
      jobcloseCategory: closeCategory
    });
  }

  //add order
  addOrderJob(
      {required String workerName,
      required String country,
      required String email,
      required String message,
      required String jobId,
      required String cvURL,
      required String workerId}) async {
    //add order
    CollectionReference orderJobCollection =
        firebaseFirestore.collection(jobOrder);
    await orderJobCollection.add({
      orderworkerName: workerName,
      ordercounty: country,
      orderworkerEmail: email,
      orderMessage: message,
      orderjobId: jobId,
      orderCv: cvURL,
      orderWorkerId: workerId
    });

    //add one to number of orders
    DocumentSnapshot docSnap =
        await firebaseFirestore.collection(jobs).doc(jobId).get();
    var data = docSnap.data() as Map<String, dynamic>;
    int numberOfOrder = data[jobNumberOfOrder];
    CollectionReference jobCollection = firebaseFirestore.collection(jobs);
    jobCollection.doc(jobId).update({jobNumberOfOrder: numberOfOrder + 1});
  }

  // get jobs
  Stream<QuerySnapshot<Map<String, dynamic>>> getJobs() {
    return firebaseFirestore.collection(jobs).snapshots();
  }

  // get job order
  Stream<QuerySnapshot<Map<String, dynamic>>> getJobOwner() {
    return firebaseFirestore
        .collection(jobOrder)
        .limit(10)
        .orderBy(jobNumberOfOrder)
        .snapshots();
  }

  //update job

  updateJob(
      {required String title,
      required double salary,
      required String description,
      required String address,
      required String type,
      required String category,
      required String closeCategory,
      required String companyId,
      required int numberOfOrder,
      required String jobId}) async {
    await firebaseFirestore.collection(jobs).doc(jobId).update({
      jobNumberOfOrder: numberOfOrder,
      jobTitle: title,
      jobSalary: salary,
      jobDescription: description,
      jobAddress: address,
      jobType: type,
      jobcompanyId: companyId,
      jobcategory: category,
      jobcloseCategory: closeCategory
    });
  }

  //delete job

  deleteJob(String docId) async {
    var jobcollection = firebaseFirestore.collection('jobs').doc(docId);
    await jobcollection.delete();
  }

  getCompanyDetails({required String comp_id}) async {
    DocumentSnapshot docSnap =
        await firebaseFirestore.collection(jobOwner).doc(comp_id).get();
    Map<String, dynamic> company = docSnap.data() as Map<String, dynamic>;
    return company;
  }

  getWorkerDetails({required String workerId}) async {
    DocumentSnapshot docSnap =
        await firebaseFirestore.collection(worker).doc(workerId).get();
    Map<String, dynamic> workerMap = docSnap.data() as Map<String, dynamic>;
    return workerMap;
  }

  getWorker() async {
    CollectionReference workerCollection =
        firebaseFirestore.collection('worker');
    QuerySnapshot workerSnapshot = await workerCollection.get();
    List<QueryDocumentSnapshot> workerList = workerSnapshot.docs;
  }

  getOrders(String jobId) {
    CollectionReference orderCollection =
        firebaseFirestore.collection(jobOrder);
    return orderCollection.where(orderjobId, isEqualTo: jobId).snapshots();
  }

  getListOfAnycolunmInJob(String ColunmName) async {
    final jobcoll = firebaseFirestore.collection(jobs);
    QuerySnapshot docSnap = await jobcoll.get();
    List<dynamic> category = [];
    docSnap.docs.forEach((element) {
      var data = element.data() as Map<String, dynamic>;
      if (!category.contains(data[ColunmName])) category.add(data[ColunmName]);
    });
    return category;
  }

  getMaxSalary() async {
    QuerySnapshot jobQuery = await firebaseFirestore
        .collection(jobs)
        .orderBy(jobSalary, descending: true)
        .limit(1)
        .get();
    JobModel job = JobModel();
    jobQuery.docs.forEach((element) {
      var data = element.data() as Map<String, dynamic>;
      job = JobModel.fromJson(data, element.id);
    });
    return job;
  }

  getMinSalary() async {
    QuerySnapshot jobQuery = await firebaseFirestore
        .collection(jobs)
        .orderBy(jobSalary)
        .limit(1)
        .get();
    JobModel job = JobModel();
    jobQuery.docs.forEach((element) {
      var data = element.data() as Map<String, dynamic>;
      job = JobModel.fromJson(data, element.id);
    });
    return job;
  }

  searchJob(
    String category, [
    String? supCategory,
    String? location,
    List? salary,
    String? type,
  ]) async {
    if (salary == null) {
      JobModel minJob = await getMinSalary();
      salary = [];
      salary.add(minJob.salary);

      JobModel maxJob = await getMaxSalary();
      salary.add(maxJob.salary);

      print(minJob.salary);
      print(maxJob.salary);
    }

    String? address = location == null ? null : location;
    QuerySnapshot querySnap = await firebaseFirestore
        .collection(jobs)
        .where(jobcategory, isEqualTo: category)
        .where(jobcloseCategory, isEqualTo: supCategory)
        .where(jobAddress, isEqualTo: address)
        .where(jobSalary,
            isGreaterThanOrEqualTo: salary[0], isLessThanOrEqualTo: salary[1])
        .where(jobType, isEqualTo: type)
        .get();
    List<JobModel> jobsList = [];
    querySnap.docs.forEach((element) {
      var data = element.data() as Map<String, dynamic>;

      jobsList.add(JobModel.fromJson(data, element.id));
    });
    return jobsList;
  }

  addMessage(
      {required message,
      required worker_id,
      required company_id,
      required Timestamp timeOfMessage,
      required sender}) async {
    var messagex = await firebaseFirestore.collection(messagesCollection).add({
      messagecomponent: message,
      workerMessage: worker_id,
      companyMessage: company_id,
      messageTime: timeOfMessage,
      messageSender: sender
    });
    print(messagex);
  }

  getMessages({worker_id, company_id}) {
    return firebaseFirestore
        .collection(messagesCollection)
        .where(workerMessage, isEqualTo: worker_id)
        .where(companyMessage, isEqualTo: company_id)
        .orderBy(messageTime, descending: true)
        .snapshots();
  }

  addNewFriend({required friend_id, required companpy_id}) async {
    await firebaseFirestore
        .collection(friends)
        .add({friendId: friend_id, companyId: companpy_id});
  }

  getFriend({required company_id}) {
    return firebaseFirestore
        .collection(friends)
        .where(companyId, isEqualTo: company_id)
        .snapshots();
  }

  getCompanyFriend({required worker_id}) {
    return firebaseFirestore
        .collection(friends)
        .where(friendId, isEqualTo: worker_id)
        .snapshots();
  }

  getLastMessage(worker_id, company_id) {
    firebaseFirestore
        .collection(messagesCollection)
        .where(workerMessage, isEqualTo: worker_id)
        .where(company_id, isEqualTo: company_id)
        .limit(1)
        .orderBy(messageTime)
        .snapshots();
  }

  // upload File using file picker

  uploadFile(
      {required String companyName,
      required String jobTitle,
      required result}) async {
    File file;
    if (result != null) {
      String fileName = result.files.first.name;
      String filePath = result.files.first.path!;
      file = File(filePath);
      // Upload file
      var ref =
          FirebaseStorage.instance.ref('CV/$companyName/$jobTitle/$fileName');
      await ref.putFile(file);
      return ref.getDownloadURL();
    }
  }
}
