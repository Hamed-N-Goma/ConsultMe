import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/AdminModel.dart';
import 'package:consultme/models/ConsultantModel.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/models/complaintsModel.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:consultme/shard/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  AdminModel? adminModel;

  String uId = CacheHelper.getData(key: "uId");

  void getAdminData() {
    print('----------get Admin Data----------');
    emit(GetProfileAdminLoadingStates());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      adminModel = AdminModel.fromJson(value.data());
      emit(GetProfileAdminSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileAdminErrorStates(error.toString()));
    });
  }

  List<UserModel>? userModel = [];
  List<ConsultantModel>? accepted_consultant = [];
  List<ConsultantModel>? waiting_consultant = [];

  void getUserInSecurity({
    String? id,
    String? username,
  }) {
    print('-----------user security-----------');

    emit(GetUserSecurityLoadingStates());

    FirebaseFirestore.instance.collection('users').get().then((value) {
      userModel = [];
      accepted_consultant = [];
      waiting_consultant = [];
      value.docs.forEach((element) {
        if (element.data()['uid'] != adminModel?.uid &&
            element.data()['userType'] == "user") {
          userModel!.add(UserModel.fromJson(element.data()));
        } else if (element.data()['uid'] != adminModel?.uid &&
            element.data()['accept'] == true) {
          accepted_consultant!.add(ConsultantModel.fromJson(element.data()));
        } else if (element.data()['uid'] != adminModel?.uid &&
            element.data()['accept'] == false) {
          waiting_consultant!.add(ConsultantModel.fromJson(element.data()));
        }
      });
    }).catchError((error) {
      print('-----------user security-----------${error.toString()}');
      emit(GetUserSecurityErrorStates(error.toString()));
    });
  }

  List<String>? posts = [];
  List<String>? users = [];
  List<ComplaintModel>? complaints = [];

  void getData() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.get().then((value) {
          posts!.add(element.id);
        }).catchError((error) {});
      });
    });

    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        element.reference.get().then((value) {
          if (element.data()['userType'] == "user") {
            users!.add(element.id);
          }
        });
      });
    });

    FirebaseFirestore.instance.collection('complaints').get().then((value) {
      value.docs.forEach((element) {
        element.reference.get().then((value) {
          complaints!.add(ComplaintModel.fromJson(element.data()));
        }).catchError((error) {});
      });
    });
  }

  void delUser(UserModel model) {
    emit(delUserLoadingStates());

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uid)
        .delete()
        .then((value) {
      emit(delUserSuccessStates());
    }).catchError((error) {
      emit(delUserErrorStates());
    });
  }

  double animatedWaitingStudentHeight = 0.0;
  bool showWaitingStudent_details = false;
  int currentWaitingStudentIndex = -1;
  void showWaitingStudentDetails(bool show, int index) {
    if (currentWaitingStudentIndex == index) {
      showWaitingStudent_details = show;
      animatedWaitingStudentHeight == 0.0
          ? animatedWaitingStudentHeight = 1000.0
          : animatedWaitingStudentHeight = 0.0;

      emit(ShowConsultantDetails());
    }
  }

  bool showEdit = false;
  void changeBuildingEditIcon(bool edit) {
    showEdit = edit;
    emit(ChangeConsultantEditIcon());
  }

  bool showStudentEdit = false;
  void changeStudentEditIcon(bool edit) {
    showStudentEdit = edit;
    emit(ChangeConsultantEditIcon());
  }

  bool showWaitingStudentEdit = false;
  void changeWaitingStudentEditIcon(bool edit) {
    showWaitingStudentEdit = edit;
    emit(ChangeConsultantEditIcon());
  }

  var idController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var imageOfCertificateController = TextEditingController();
  var phoneController = TextEditingController();
  var departmentController = TextEditingController();
  var speachalistController = TextEditingController();
  var yearsofExperienceController = TextEditingController();
  var acceptController = TextEditingController();

  void inputData(ConsultantModel item) {
    idController.text = item.uid!;
    nameController.text = item.name!;
    emailController.text = item.email!;
    phoneController.text = item.phone!;
    speachalistController.text = item.speachalist!.toString();
    departmentController.text = item.department!;
    yearsofExperienceController.text = item.yearsofExperience!;
    imageOfCertificateController.text = item.imageOfCertificate ?? "";
    acceptController.text = item.accept!.toString();
    emit(InputDataSuccess());
  }

  void putConsultant({
    required String uid,
    required String name,
    required String email,
    required String phone,
    required bool accept,
    required String department,
    required String speachalist,
    required String yearsofExperience,
    required String imageOfCertificate,
  }) {
    ConsultantModel consultantModel = ConsultantModel(
      name: name,
      email: email,
      accept: false,
      uid: uid,
      phone: phone,
      department: department,
      speachalist: speachalist,
      yearsofExperience: yearsofExperience,
      userType: 'Consultant',
    );
    emit(PutConsultantLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(consultantModel.toMap())
        .then((value) => {
              print('consultant created '),
            })
        .then((value) {
      emit(PutConsultantSuccessStates());
    }).catchError((error) {
      print(error);
      showToast(
          message: 'حدث خطأ ما, برجاء المحاوله في وقت لاحق',
          state: ToastStates.ERROR);
      emit(PutConsultantErrorStates(error.toString()));
    });
  }

  void AcceptConsultant({
    required String uid,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'accept': true})
        .then((value) => {
              print('consultant accepted '),
            })
        .then((value) {
          getUserInSecurity();
          emit(AcceptedConsultantSuccessStates());
          showToast(message: 'تم القبول بنجاح', state: ToastStates.SUCCESS);
        })
        .catchError((error) {
          print(error);
          showToast(
              message: 'حدث خطأ ما, برجاء المحاوله في وقت لاحق',
              state: ToastStates.ERROR);
          emit(AcceptedConsultantErrorStates(error.toString()));
        });
  }

  void UnAcceptConsultant({
    required String uid,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'accept': false})
        .then((value) => {
              print('consultant accepted '),
            })
        .then((value) {
          emit(AcceptedConsultantSuccessStates());
          getUserInSecurity();
          showToast(message: 'تم التقييد بنجاح', state: ToastStates.SUCCESS);
        })
        .catchError((error) {
          print(error);
          showToast(
              message: 'حدث خطأ ما, برجاء المحاوله في وقت لاحق',
              state: ToastStates.ERROR);
          emit(AcceptedConsultantErrorStates(error.toString()));
        });
  }

  void deleteConsultant(id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteConsultantSuccess());
      showToast(message: 'تم الحذف بنجاح', state: ToastStates.SUCCESS);
    }).catchError((error) {
      print(error.toString());

      emit(DeleteConsultantError(error.toString()));
      showToast(
          message: 'حدث خطأ ما, برجاء المحاولة في وقت لاحق',
          state: ToastStates.ERROR);
    });
  }

  List<UserModel> Users = [];

  void getUsers() async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    await user.where('userType', isEqualTo: 'user').get().then(
          (user) => {
            Users = user.docs
                .map(
                    (e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
                .toList(),
            emit(GitUsersDataSucsess(Users)),
            user.docs.forEach((element) {
              print(element.data());
              print("++++============================");
            })
          },
        );
  }
}
