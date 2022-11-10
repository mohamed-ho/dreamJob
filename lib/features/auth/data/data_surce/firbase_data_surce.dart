import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dreamjob/core/constants/string.dart';
import 'package:dreamjob/core/function/shaedprefrence_function.dart';
import 'package:dreamjob/features/Home/view/screens/control_screen.dart';
import 'package:dreamjob/features/company/Home/screens/control_company_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../../../core/widgets/custom_Error_dialog.dart';
import '../../../../main.dart';

class AuthFirebaseDataSurce {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final String hash = 'engmohamedhosnyhassn';
  void updateProfile(userName, [image]) async {
    await user?.updateDisplayName(userName);
    await user?.updatePhotoURL(image);
  }

  // add worker
  Future<void> signUpAsWorker(email, password, userName, context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      CollectionReference workerCollection =
          firebaseFirestore.collection(worker);
      await workerCollection.add(
          {workerEmail: email, workerUserName: userName, workerImage: noImage});

      CustomCorrectDialog(
          context, 'account is created successfully', 'Success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomErrorDialog(context,
            'Weak password please enter another password', 'password Error');
      } else if (e.code == 'email-already-in-use') {
        CustomErrorDialog(context,
            'email already used please enter another email', 'Email Error');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInAsWorker(email, password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await sharedpref.setBool(checkLogin, true);
      await sharedpref.setBool(isCompany, false);
      print('================================');
      //print(await sharedpref.getString(checkLogin));
      print('==============================');
      await addWorkerDataToSharedPrefrence();
      Navigator.pushNamedAndRemoveUntil(
        context,
        ControlScreen.id,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomErrorDialog(
            context, 'user not found, please try again ', 'Error');
      } else if (e.code == 'wrong-password') {
        CustomErrorDialog(context, 'your password or email is wrong', 'Error');
      } else {
        CustomErrorDialog(context,
            'you have wrong please try again in another time', 'Error');
      }
    }
  }

  //add jobOwner
  Future<void> signUpAsJobOwner(email, password, userName, context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: generateJobOwnerPassword(password),
      );

      CollectionReference workerCollection =
          firebaseFirestore.collection('jobOwner');
      workerCollection
          .add({'email': email, 'userName': userName, jobOwnerImage: noImage});

      CustomCorrectDialog(
          context, 'account is created successfully', 'Success');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInAsJobOwner(email, password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: generateJobOwnerPassword(password));
      sharedpref.setBool(checkLogin, true);
      sharedpref.setBool(isCompany, true);
      await addCompanyDataToSharedprefrence();
      Navigator.pushNamedAndRemoveUntil(
          context, ControlCompanyScreen.id, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomErrorDialog(
            context, 'Company not found, please try again ', 'Error');
      } else if (e.code == 'wrong-password') {
        CustomErrorDialog(context, 'your password or email is wrong', 'Error');
      } else {
        CustomErrorDialog(context,
            'you have wrong please try again in another time', 'Error');
      }
    }
  }

  String generateJobOwnerPassword(String password) {
    return '${password}$hash';
  }

  bool checkJobOwnerPassword(String jobOwnerPassword, String firebasePasswod) {
    String checkHash =
        firebasePasswod.substring(firebasePasswod.length - hash.length);
    print(checkHash);
    String checkPassword = firebasePasswod.substring(
        0, (firebasePasswod.length - checkHash.length));
    print(checkPassword);
    if (hash == checkHash && jobOwnerPassword == checkPassword)
      return true;
    else
      return false;
  }
}

class FirebaseTest {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  getOrder() async {
    CollectionReference orderCollection =
        firebaseFirestore.collection('orderJob');
    await orderCollection
        .limit(2) // it is used to return '2' order
        .orderBy('workerName',
            descending: false) // it is used to sort by 'workerName'
        .where('jobId',
            isEqualTo:
                'aVNI1hCDgOzOQrSEsMCV') //it is used to show data using specific condation
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.data());
                print('===================================');
              })
            });
  }

  getOrderUsedsanpshot() async {
    CollectionReference orderCollection =
        firebaseFirestore.collection('orderJob');
    await orderCollection.snapshots().listen((element) {
      // it is used when you need to update data all time
      element.docs.forEach((element) {
        print(element.data());
      });
    });
  }

  addUserAuto() async {
    CollectionReference userCollection = firebaseFirestore.collection('worker');
    await userCollection.add({
      'name':
          'yasser', //! key of map should be take the same name that in firebase
      'email':
          'yassey@gmail.com' //! it use if you want the id of this user created auto
    });
  }

  addUser() async {
    CollectionReference userCollection = firebaseFirestore.collection('worker');
    await userCollection //it use to add user in firebase
        .doc(
            '1234565432') //! it use if you want add id of this user id = '1234565432'
        .set({'name': 'kalaf ahmed', 'email': 'Kalaf@gmail.com'});
  }

  updateUserUsingUPdate() async {
    CollectionReference userCollection = firebaseFirestore.collection('worker');
    await userCollection // it is used to update user
        .doc(
            '0GXy3Mvv5pprZBMQAKRb') //! '1234565432' is the id of user it is should be correct if it is rwong it will throw error
        .update({
          'name': 'yhya',
          'email': 'yhya@gmail.com'
        }) //! key of map should be take the same name that in firebase
        .then((value) => print('update success'))
        .catchError((error) {
          print('you have arror $error');
        });
  }

  updateUserUsingSet() async {
    CollectionReference userCollection = firebaseFirestore.collection('worker');
    await userCollection // it is used to delete user and create new user have the same id
        .doc(
            '1234565432') //! '1234565432' is the id of user it is should be correct if it is rwong it will create a user have the rowng id
        .set({
      'name': 'Ali',
      'email': 'ali@gmail.com'
    }); //! key of map should be take the same name that in firebase if it is rowng it will create a field have the rowng key
    //! if you change only one field anather field would be deleted
  }

  updateUserUsingSetOptions() async {
    CollectionReference userCollection = firebaseFirestore.collection('worker');
    await userCollection // it is used to delete user and create new user have the same id
        .doc(
            '1234565432') //! '1234565432' is the id of user it is should be correct if it is rwong it will create a user have the rowng id
        .set(
            {'name': 'Ali', 'email': 'NOali@gmail.com'},
            SetOptions(
                merge:
                    true)); //! key of map should be take the same name that in firebase if it is rowng it will create a field have the rowng key
    //! if you change only one field anather field don't delete becouse you used SetOPthions(merge:true)
  }

  addUserandUsingThenandCatchError() async {
    CollectionReference userCollection = firebaseFirestore.collection('worker');
    await userCollection
        .add({'name': 'maya', 'email': 'maya@gmail.com'})
        .then((value) => print(
            'add success')) // it used to return same thing if add function success
        .catchError((error) {
          // it used to return same thing if add function is fail
          print('you have error$error');
        }); //! 'then' and 'chatchError' it can used in add and update and delete methond in firebase
  }

  deleteUser() async {
    CollectionReference userCollection = firebaseFirestore.collection('worker');
    await userCollection
        .doc('1234565432')
        .delete()
        .then((value) => print('deleted success'))
        .catchError((error) {
      print('deleted fail');
    });
  }

  CreateNewCollaction() async {
    CollectionReference testCollection = firebaseFirestore.collection('test');
    await testCollection.add({
      'testName': 'test1',
      'testNumber': 1,
    });

    CollectionReference addressCollection =
        testCollection.doc().collection('address');
    await addressCollection
        .add({'country': 'Egypt', 'city': 'Sohag', 'postNamber': 930});
  }

  getaddressData() async {
    CollectionReference addressColletion = firebaseFirestore
        .collection('test')
        .doc('NALq9jRnawhykDl89Fy3')
        .collection('address');
    await addressColletion.get().then((value) => {
          value.docs.forEach((element) {
            var data = element.data()! as Map<String, dynamic>;
            print('${data['country']}');
            print('======================');
          }),
        });
  }

  updateTestUsingTransaction() async {
    DocumentReference trans =
        firebaseFirestore.collection('test').doc('cw6hUhsHPgunsaqhtNF9');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      // in transaction you should read first and write after this
      DocumentSnapshot docSnap =
          await transaction.get(trans); // read in transaction
      if (docSnap.exists) {
        transaction.update(trans, {
          'textName': 'test2',
          'testNumber': 43,
        }); // write in transaction
      } else {
        print('test not found');
      }
    });
  }

  updateUsingBatch() async {
    DocumentReference docOne =
        firebaseFirestore.collection('test').doc('cw6hUhsHPgunsaqhtNF9');
    DocumentReference docTwo =
        firebaseFirestore.collection('test').doc('g8oNeGAlNwD00Xai0AhB');
    WriteBatch batch = FirebaseFirestore.instance.batch(); //create batch
    batch.update(docOne,
        {'testName': 'test55', 'testNumber': 343}); // update docOne using batch
    batch.update(docTwo,
        {'testName': 'test22', 'testNumber': 22}); // update docTwo using batch
    batch.commit(); //run batch in same time
    //! in batch all update existed or no one exist and you should commit batch to do updates
  }

  uploadImage() async {
    File? file;
    ImagePicker imagePicker = ImagePicker();

    var imagefile = await imagePicker.pickImage(source: ImageSource.camera);
    if (imagefile != null) {
      file = File(imagefile.path);

      String imageName =
          basename(imagefile.path); // function to cut imagename from path
      Random random = Random();
      imageName = '${random.nextInt(1000000)}$imageName';
      Reference firebaseStorage = FirebaseStorage.instance
          .ref('image/$imageName'); //create reference to upload file in it
      await firebaseStorage.putFile(file); //upload flie
      var url = await firebaseStorage
          .getDownloadURL(); //get url that image is storged in it
    } else
      print('pleace shoce file');
  }

  uploadFile({required String companyName, required String jobTitle}) async {
    File file;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx', 'pdf', 'doc'],
    );
    if (result != null) {
      String fileName = result.files.first.name;
      String filePath = result.files.first.path!;
      file = File(filePath);
      // Upload file
      await FirebaseStorage.instance
          .ref('CV/$companyName/$jobTitle/$fileName')
          .putFile(file);
    }
  }

  getAllFileInRef() async {
    ListResult ref = await FirebaseStorage.instance.ref().list(
        ListOptions(maxResults: 3)); // reference in root get 3 or less  item

    ref.items.forEach((element) {
      //foreach to  get file
      print(element.name); // print name
      print(element.fullPath); //print path
      print('====================');
    });

    ref.prefixes.forEach((element) {
      // foreach to get folder
      print(element.name); //print name
      print(element.fullPath); // print path
    });
  }
}
