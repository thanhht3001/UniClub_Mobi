import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/screens/university_selection/widgets/dropdown_department.dart';

import '../../bloc/university_selection/university_selection_bloc.dart';
import '../../bloc/university_selection/university_selection_event.dart';
import '../../bloc/university_selection/university_selection_state.dart';

import '../../models/entities/uni_selector/uni_selector_model.dart';
import '../../models/entities/user/complete_profile.dart';
import '../../utils/app_color.dart';
import '../../utils/dimens.dart';
import '../../utils/router.dart';
import 'widgets/dob.dart';
import 'widgets/dropdown_university.dart';
import 'widgets/select_gender.dart';

class UniversitySelectionPage extends StatefulWidget {
  final UniversitySelectionBloc bloc;

  UniversitySelectionPage({required this.bloc});

  @override
  State<UniversitySelectionPage> createState() =>
      _UniversitySelectionPageState();
}

class _UniversitySelectionPageState extends State<UniversitySelectionPage> {
  UniversitySelectionBloc get bloc => widget.bloc;
  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeyDescription = GlobalKey<FormState>();
  final _formStudentCode = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc.listenerStream.listen((event) {
      if (event is NavigatorWelcomePageEvent) {
        Navigator.of(context).pushReplacementNamed(Routes.main);
      } else if (event is ShowingSnackBarEvent) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message)));
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //nhận data từ trang login
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      List<UniBelongToEmail> listUniBelongToEmail =
          settings.arguments as List<UniBelongToEmail>;

      if (listUniBelongToEmail != null) {
        //thêm sự kiện để cập nhật state
        bloc.add(ReceiveData(listUniBelongToEmail: listUniBelongToEmail));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Cập nhật thông tin"),
          ),
          backgroundColor: AppColors.mainColor,
          automaticallyImplyLeading: false,
        ),
        body: BlocProvider.value(
            value: bloc,
            child: BlocBuilder<UniversitySelectionBloc,
                    UniversitySelectionState>(
                bloc: bloc,
                builder: (context, state) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: Column(
                        children: [
                          DropdownUniversity(),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownDepartment(),
                          const SizedBox(
                            height: 10,
                          ),
                          //TextfieldInputPhone(),
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Số Điện Thoại:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: size.width,
                                  child: BlocBuilder<UniversitySelectionBloc,
                                          UniversitySelectionState>(
                                      bloc: bloc,
                                      builder: (context, state) {
                                        return Form(
                                          key: _formKeyPhone,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                              // controller: TextEditingController()..text = state.poiReceive.address,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              //maxLength: 10,
                                              minLines: 1,
                                              //maxLines: 3,
                                              validator: (value) {
                                                if (value!.trim().length < 10) {
                                                  return 'Nhập ít nhất 10 ký tự';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                if (_formKeyPhone.currentState!
                                                    .validate()) {
                                                  bloc.add(ChangePhoneValue(
                                                      newPhoneValue:
                                                          value.trim()));
                                                }
                                                //   state.poiReceive.address = value;
                                              }),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //TextfieldInputStudentCode(),
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Mã Số Sinh Viên:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: size.width,
                                  child: BlocBuilder<UniversitySelectionBloc,
                                          UniversitySelectionState>(
                                      bloc: bloc,
                                      builder: (context, state) {
                                        return Form(
                                          key: _formStudentCode,
                                          child: TextFormField(
                                              // controller: TextEditingController()..text = state.poiReceive.address,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              //maxLength: 10,
                                              minLines: 1,
                                              //maxLines: 3,
                                              validator: (value) {
                                                if (value!.trim().length < 4) {
                                                  return 'Nhập ít nhất 4 ký tự';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                if (_formStudentCode
                                                    .currentState!
                                                    .validate()) {
                                                  bloc.add(
                                                      ChangeStudentCodeValue(
                                                          newStudentCodeValue:
                                                              value.trim()));
                                                }
                                                //   state.poiReceive.address = value;
                                              }),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DateOfBirth(),
                          SelectGender(
                              showOtherGender: false, alignVertical: true),

                          //TextfieldInputDescription(),
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Giới Thiệu Về Bản Thân",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: size.width,
                                  child: BlocBuilder<UniversitySelectionBloc,
                                          UniversitySelectionState>(
                                      bloc: bloc,
                                      builder: (context, state) {
                                        return Form(
                                          key: _formKeyDescription,
                                          child: TextFormField(
                                              // controller: TextEditingController()..text = state.poiReceive.address,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              //maxLength: 250,
                                              minLines: 1,
                                              maxLines: 10,
                                              validator: (value) {
                                                if (value!.trim().length < 10) {
                                                  return 'Nhập ít nhất 10 ký tự';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                if (_formKeyDescription
                                                    .currentState!
                                                    .validate()) {
                                                  bloc.add(
                                                      ChangeDescriptionValue(
                                                          newDescriptionValue:
                                                              value.trim()));
                                                }
                                                //   state.poiReceive.address = value;
                                              }),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_formKeyDescription.currentState!
                                  .validate()) {
                                if (_formKeyPhone.currentState!.validate()) {
                                  if (_formStudentCode.currentState!
                                      .validate()) {
                                    bloc.add(CompletelyProfile(
                                        completeProfileModel: CompleteProfile(
                                      universityId: state.universityId,
                                      departmentId: state.departmentId,
                                      dob: state.dob,
                                      gender: state.gender,
                                      phone: state.phone,
                                      studentCode: state.studentCode,
                                      description: state.description,
                                    )));
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     SnackBar(
                                    //         content: Text(
                                    //             "Đã Update Thành Công !")));
                                  }
                                }
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  color: Colors.orange[600],
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 50.0, vertical: Dimens.size30),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(width: 5),
                                      Text(
                                        "Xác Nhận",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                }))

        // body: Container(
        //   child: ListView.builder(
        //       itemCount: listUniBelongToEmail.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         return Container(
        //           height: 50,
        //           child: Text("${listUniBelongToEmail[index].name}"),
        //         );
        //       }),
        // ),
        );
  }
}
