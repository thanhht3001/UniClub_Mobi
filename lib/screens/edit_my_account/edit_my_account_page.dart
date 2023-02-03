import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unicec_mobi/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:unicec_mobi/bloc/edit_profile/edit_profile_state.dart';
import 'package:unicec_mobi/models/common/current_user.dart';
import 'package:unicec_mobi/models/entities/department/department_model.dart';
import 'package:unicec_mobi/models/enums/user_status.dart';
import 'package:unicec_mobi/screens/widgets/input.dart';

import '../../bloc/edit_profile/edit_profile_event.dart';
import '../../constants/Theme.dart';
import '../../models/entities/user/user_model.dart';
import '../../utils/app_color.dart';
import '../../utils/loading.dart';
import '../../utils/log.dart';

class EditMyAccountPage extends StatefulWidget {
  EditProfileBloc bloc;

  EditMyAccountPage({required this.bloc});

  @override
  State<StatefulWidget> createState() => _EditMyAccountPageState();
}

class _EditMyAccountPageState extends State<EditMyAccountPage>
    with AutomaticKeepAliveClientMixin {
  EditProfileBloc get _bloc => widget.bloc;
  int userId = GetIt.I.get<CurrentUser>().id;
  int universityId = GetIt.I.get<CurrentUser>().universityId!;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bloc.add(LoadProfileEvent(userId: userId));
    _bloc.add(LoadDepartmentsByUni(universityId: universityId));
    _bloc.isLoading = true;

    _bloc.listenerStream.listen((event) {
      if (event is ShowPopUpAnnouncement) {
        if (event.message.contains("thành công")) {
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Thành Công',
            desc: 'Cập nhật thành công',
            btnOkOnPress: () {},
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            },
          ).show();
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'Thất bại',
            desc: 'Cập nhật thất bại',
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
        }
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(event.message)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const defaultImage = 'https://picsum.photos/seed/513/600';
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        bloc: _bloc,
        builder: (context, state) {
          Log.info('state: ${state.user}');
          final fullnameController =
              TextEditingController(text: state.user?.fullname ?? '');
          final studentCodeController =
              TextEditingController(text: state.user?.studentCode ?? '');
          final descriptionController =
              TextEditingController(text: state.user?.description ?? '');
          final universityController =
              TextEditingController(text: state.user?.universityName ?? '');
          final emailController =
              TextEditingController(text: state.user?.email ?? '');
          final phoneController =
              TextEditingController(text: state.user?.phoneNumber ?? '');
          final dobController =
              TextEditingController(text: state.user?.dob ?? '');

          Log.info('departments: ${state.departments}');
          DepartmentModel selectedDepartment = DepartmentModel(
              id: 0,
              universityId: universityId,
              majorId: 0,
              departmentCode: 'SE',
              name: 'name',
              description: 'description',
              status: true);
          // state.departments![0];
          // !.firstWhere((element) => element.id == state.user?.departmentId);
          Log.info('user: ${state.user?.departmentId}');

          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context, state.user?.id);
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                title: const Text("Chỉnh sửa thông tin",
                    style: TextStyle(color: Colors.white)),
                centerTitle: true,
                backgroundColor: AppColors.mainColor,
              ),
              backgroundColor: AppColors.backgroundPageColor,
              body: (_bloc.isLoading)
                  ? Loading()
                  : Stack(children: <Widget>[
                      SafeArea(
                        child: ListView(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 90.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Stack(children: <Widget>[
                                  Container(
                                    child: Container(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 85.0, bottom: 20.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Text(
                                                  "Họ và tên",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              controller: fullnameController,
                                              placeholder: "",
                                              prefixIcon: const Icon(Icons
                                                  .drive_file_rename_outline),
                                            ),
                                          ),
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Text(
                                                  "MSSV",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              controller: studentCodeController,
                                              placeholder: "",
                                              prefixIcon:
                                                  const Icon(Icons.label),
                                            ),
                                          ),
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Text(
                                                  "Miêu tả bản thân",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              controller: descriptionController,
                                              placeholder: "",
                                              prefixIcon:
                                                  const Icon(Icons.description),
                                            ),
                                          ),
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Text(
                                                  "Trường",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              controller: universityController,
                                              isReadOnly: true,
                                              placeholder: "",
                                              prefixIcon:
                                                  const Icon(Icons.school),
                                            ),
                                          ),
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Text(
                                                  "Ngành học",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 5.0),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            child: Column(children: [
                                              DropdownButton(
                                                  isExpanded: true,
                                                  value: state.selectedDepartment ??
                                                      state.departments?.firstWhere(
                                                          (element) => (state.user
                                                                      ?.departmentId !=
                                                                  null)
                                                              ? element.id ==
                                                                  state.user
                                                                      ?.departmentId
                                                              : element.id ==
                                                                  state
                                                                      .departments?[
                                                                          0]
                                                                      .id),
                                                  items: state.departments?.map(
                                                    (DepartmentModel
                                                        department) {
                                                      return DropdownMenuItem(
                                                          value: department,
                                                          child: Text(
                                                              department.name));
                                                    },
                                                  ).toList(),
                                                  onChanged: (DepartmentModel?
                                                      selectedValue) {
                                                    setState(() {
                                                      state.selectedDepartment =
                                                          selectedValue!;
                                                      Log.info(
                                                          'SelectedValue: ${state.selectedDepartment?.name}');
                                                    });
                                                  })
                                            ]),
                                          ),
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Text(
                                                  "Email",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              controller: emailController,
                                              placeholder: "",
                                              prefixIcon:
                                                  const Icon(Icons.email),
                                            ),
                                          ),
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Text(
                                                  "Số điện thoại",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              controller: phoneController,
                                              placeholder: "",
                                              prefixIcon:
                                                  const Icon(Icons.phone),
                                            ),
                                          ),
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Text(
                                                  "Ngày sinh",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              controller: dobController,
                                              placeholder: "",
                                              prefixIcon:
                                                  const Icon(Icons.cake),
                                            ),
                                          ),
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, top: 8),
                                                child: Text(
                                                  "Giới tính",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 5.0),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            child: Column(children: [
                                              DropdownButton(
                                                  isExpanded: true,
                                                  value: state.selectedGender ??
                                                      state.genderSelection
                                                          .firstWhere(
                                                              (element) =>
                                                                  element ==
                                                                  state.user
                                                                      ?.gender,
                                                              orElse: () =>
                                                                  state.genderSelection[
                                                                      0]),
                                                  items:
                                                      state.genderSelection.map(
                                                    (String gender) {
                                                      return DropdownMenuItem(
                                                          value: gender,
                                                          child: Text(
                                                              (gender.contains(
                                                                      "Male"))
                                                                  ? "Nam"
                                                                  : "Nữ"));
                                                    },
                                                  ).toList(),
                                                  onChanged:
                                                      (String? selectedValue) {
                                                    setState(() {
                                                      Log.info(
                                                          'SelectedValue: $selectedValue');
                                                      state.selectedGender =
                                                          selectedValue!;
                                                    });
                                                  })
                                            ]),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: FractionalTranslation(
                                        translation: Offset(0.0, -0.5),
                                        child: Align(
                                          alignment: FractionalOffset(0.5, 0.0),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                //AssetImage(
                                                state.user?.avatar != null
                                                    ? "${state.user?.avatar}"
                                                    : defaultImage),
                                            radius: 65.0,
                                            // maxRadius: 200.0,
                                          ),
                                        )),
                                  )
                                ]),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(
                                        right: 15, left: 15, bottom: 15),
                                    child: FlatButton(
                                      textColor: ArgonColors.white,
                                      color: ArgonColors.warning,
                                      onPressed: () {
                                        Log.info(
                                            "onPress - selectedDepartment: ${state.selectedDepartment?.name} - ${state.selectedDepartment?.id}");
                                        UserModel user = UserModel(
                                            id: (state.user?.id)!,
                                            roleId: (state.user?.roleId)!,
                                            email: emailController.value.text,
                                            fullname:
                                                fullnameController.value.text,
                                            avatar: (state.user?.avatar)!,
                                            gender: state.selectedGender ??
                                                state.user?.gender ??
                                                'Male',
                                            departmentId:
                                                state.selectedDepartment?.id,
                                            studentCode:
                                                (state.user?.studentCode)!,
                                            phoneNumber:
                                                phoneController.value.text,
                                            status: UserStatus
                                                .Active, // default status
                                            dob: dobController.value.text,
                                            description: descriptionController
                                                .value.text,
                                            isOnline: true);
                                        _bloc.add(EditInfoEvent(user: user));
                                        //Navigator.pop(context, user.id);
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0,
                                              right: 16.0,
                                              top: 12,
                                              bottom: 12),
                                          child: Text("Lưu chỉnh sửa",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18.0))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      )
                    ]));
        });
  }
}
