import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/view_list_team_participant/view_list_team_participant_bloc.dart';
import '../../../bloc/view_list_team_participant/view_list_team_participant_event.dart';
import '../../../bloc/view_list_team_participant/view_list_team_participant_state.dart';
import '../../../constants/Theme.dart';
import '../../../models/enums/team_status.dart';
import 'list_team_menu.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
//   @override
  final _formKeyInvitedCode = GlobalKey<FormState>();
  var _controller = TextEditingController();

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<ViewListTeamParticipantBloc>(context)
        .add(ViewListTeamInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    ViewListTeamParticipantBloc bloc =
        BlocProvider.of<ViewListTeamParticipantBloc>(context);
    return BlocBuilder<ViewListTeamParticipantBloc,
            ViewListTeamParticipantState>(
        bloc: bloc,
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () {
              return _refresh(context);
            },
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: TextFormField(
                              controller: _controller,
                              onFieldSubmitted: (value) {
                                bloc.add(
                                    ChangeSearchNameEvent(searchName: value));
                              },
                              autofocus: false,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      _controller.clear;
                                      _controller.text = "";
                                      //s???a l???i c??i
                                      bloc.add(ChangeSearchNameEvent(
                                          searchName: null));
                                    },
                                    icon: const Icon(Icons.clear)),
                                labelText: 'T??m T??n ?????i',
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          bloc.add(LoadingEvent());
                          bloc.add(SearchEvent());
                        },
                        child: const Icon(Icons.search),
                      ),
                      PopupMenuButton<int>(
                          icon: const Icon(Icons.filter_alt_outlined),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                onTap: () {
                                  bloc.add(LoadingEvent());
                                  bloc.add(ChangeTeamStatusEvent(
                                      status: TeamStatus.Available));
                                },
                                value: 1,
                                child: (state.status == TeamStatus.Available)
                                    ? Container(
                                        child: Row(
                                          children: <Widget>[
                                            //Icon(Icons.camera, size: 18),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text('M???',
                                                  style: TextStyle(
                                                      color:
                                                          ArgonColors.warning)),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Row(
                                        children: <Widget>[
                                          //Icon(Icons.camera, size: 18),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text('M???'),
                                          ),
                                        ],
                                      ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  bloc.add(LoadingEvent());
                                  bloc.add(ChangeTeamStatusEvent(
                                      status: TeamStatus.IsLocked));
                                },
                                value: 2,
                                child: (state.status == TeamStatus.IsLocked)
                                    ? Container(
                                        child: Row(
                                          children: <Widget>[
                                            //Icon(Icons.school, size: 18),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                '????ng',
                                                style: TextStyle(
                                                    color: ArgonColors.warning),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Row(
                                        children: <Widget>[
                                          //Icon(Icons.school, size: 18),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text('????ng'),
                                          ),
                                        ],
                                      ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  _controller.text = "";
                                  bloc.add(LoadingEvent());
                                  bloc.add(ResetFilterEvent());
                                },
                                value: 3,
                                child: ((state.status !=
                                            TeamStatus.Available) &&
                                        (state.status != TeamStatus.IsLocked))
                                    ? Container(
                                        child: Row(
                                          children: <Widget>[
                                            //Icon(Icons.camera, size: 18),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text('T???t c???',
                                                  style: TextStyle(
                                                      color:
                                                          ArgonColors.warning)),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Row(
                                        children: <Widget>[
                                          //Icon(Icons.delete, size: 18),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text('T???t C???'),
                                          ),
                                        ],
                                      ),
                              ),
                            ];
                          }),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                        child: Text(
                      "T??n ??????i",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                    Expanded(
                        child: Text(
                      "S???? tha??nh vi??n",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      "Tra??ng tha??i",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                    Expanded(
                        child: Text(
                      "Chi ti????t",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                  ],
                ),
                ViewListTeamMenu(),
                const SizedBox(height: 20),
                //Kh??c ?????u ????n th?? xu???t hi???n m?? tham gia
                if (state.listTeam.isNotEmpty && (state.maxNumber != 1))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: ArgonColors.warning),
                            color: ArgonColors.warning,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        child: FlatButton(
                            textColor: ArgonColors.white,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      scrollable: true,
                                      title: const Text(
                                        'Nh????p ma?? tham gia',
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                          ),
                                          child: Form(
                                            key: _formKeyInvitedCode,
                                            child: TextFormField(
                                                decoration: InputDecoration(
                                                  prefixIcon:
                                                      Icon(Icons.description),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                maxLength: 20,
                                                minLines: 1,
                                                maxLines: 2,
                                                validator: (value) {
                                                  if (value!.length < 4) {
                                                    return 'Nh???p ??t nh???t 4 k?? t???';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  if (_formKeyInvitedCode
                                                      .currentState!
                                                      .validate()) {
                                                    bloc.add(
                                                        ChangeInvitedCodeValueEvent(
                                                            newInvitedCodeValue:
                                                                value));
                                                  }
                                                }),
                                          )),
                                      actions: [
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                              right: 15, left: 15, bottom: 15),
                                          child: FlatButton(
                                            textColor: ArgonColors.white,
                                            color: ArgonColors.warning,
                                            onPressed: () {
                                              if (_formKeyInvitedCode
                                                  .currentState!
                                                  .validate()) {
                                                bloc.add(JoinTeamEvent());
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 12,
                                                    bottom: 12),
                                                child: Text("Tham gia",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.0))),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Text("Nh????p ma?? tham gia",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0))),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: ArgonColors.warning),
                        color: ArgonColors.warning,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: AnimatedButton(
                        width: 200,
                        text: 'L??u ?? c???a Cu???c Thi',
                        color: ArgonColors.warning,
                        pressEvent: () {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.WARNING,
                              headerAnimationLoop: true,
                              animType: AnimType.SCALE,
                              body: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'L??u ??',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: ArgonColors.error),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 20, left: 20, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                              'Quy ?????nh v??? ?????i Thi c???a Cu???c Thi',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          '1.T???o, Tham Gia ?????i khi Cu???c Thi ch??a di???n ra.'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '2.Tham Gia ?????i khi tr???ng th??i c???a ?????i l?? M???.'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '3.Chuy???n tr???ng th??i ????ng ?????i ???????c khi s??? l?????ng th??nh vi??n trong ?????i ????ng theo quy ?????nh c???a Cu???c thi ????a ra.'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '4.?????i ??? tr???ng th??i ????ng th?? Ban T??? Ch???c m???i duy???t tr??? th??nh ?????i tham gia ch??nh th???c c??n l???i h???y b???.'),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Quy ?????nh v??? S??? L?????ng th??nh vi??n ?????i',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                (state.maxNumber == state.minNumber)
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20.0,
                                            left: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Text(
                                            'S??? l?????ng th??nh vi??n trong ?????i h???p l??? ph???i ????ng ${state.maxNumber} th??nh vi??n'),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20.0,
                                            left: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Text(
                                            'S??? l?????ng th??nh vi??n trong ?????i h???p l??? t???i thi???u t??? ${state.minNumber} tr??? l??n v?? kh??ng v?????t qu?? ${state.maxNumber} th??nh vi??n'),
                                      ),
                              ])).show();
                          // title: '',
                          // desc: ''
                          //         '\n '
                          //         '\n 2.Tham Gia ?????i khi tr???ng th??i c???a ?????i l?? M???.'
                          //         '\n 3.Chuy???n tr???ng th??i ????ng ?????i ???????c khi s??? l?????ng th??nh vi??n trong ?????i ????ng theo quy ?????nh c???a Cu???c thi ????a ra.'
                          //         '\n 4.?????i ??? tr???ng th??i ????ng th?? Ban T??? Ch???c m???i duy???t tr??? th??nh ?????i tham gia ch??nh th???c c??n l???i h???y b???.'
                          //         '\n'
                          //         '\n Quy ?????nh v??? S??? L?????ng th??nh vi??n ?????i\n' +
                          //     '${(state.maxNumber == state.minNumber) ? 'S??? l?????ng th??nh vi??n trong ?????i h???p l??? ph???i ????ng ${state.maxNumber} th??nh vi??n' : 'S??? l?????ng th??nh vi??n trong ?????i h???p l??? t???i thi???u t??? ${state.minNumber} tr??? l??n v?? kh??ng v?????t qu?? ${state.maxNumber} th??nh vi??n'}')
                        }),
                  ),
                ]),
              ]),
            ),
          );
        });
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<ViewListTeamParticipantBloc>(context).add(RefreshEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 5000));
    refresh(context);
    return true;
  }
}
