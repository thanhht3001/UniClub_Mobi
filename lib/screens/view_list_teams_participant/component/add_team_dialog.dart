import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/add_team_dialog/add_team_dialog_bloc.dart';
import '../../../bloc/add_team_dialog/add_team_dialog_event.dart';
import '../../../bloc/add_team_dialog/add_team_dialog_state.dart';
import '../../../constants/Theme.dart';

class AddTeamDialog extends StatefulWidget {
  AddTeamDialogBloc bloc;
  AddTeamDialog({required this.bloc});
  @override
  State<AddTeamDialog> createState() => _AddTeamDialogState();
}

class _AddTeamDialogState extends State<AddTeamDialog> {
  final _formKeyTeamName = GlobalKey<FormState>();

  final _formKeyTeamDescription = GlobalKey<FormState>();
  //
  AddTeamDialogBloc get bloc => widget.bloc;

  @override
  void initState() {
    bloc.listenerStream.listen((event) {
      if (event is SendingDataEvent) {
        Navigator.of(context, rootNavigator: true).pop(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<AddTeamDialogBloc, AddTeamDialogState>(
        bloc: bloc,
        builder: (context, state) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            scrollable: true,
            title: Container(
                child: Text(
              'Tạo đội',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )),
            content: Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      Text('Tên đội'),
                    ],
                  ),
                ),
                Form(
                  key: _formKeyTeamName,
                  child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.label),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      //maxLength: 50,
                      minLines: 1,
                      maxLines: 3,
                      validator: (value) {
                        if (value!.trim().length < 5) {
                          return 'Nhập ít nhất 5 ký tự';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_formKeyTeamName.currentState!.validate()) {
                          bloc.add(ChangeTeamNameValueEvent(
                              newNameValue: value.trim()));
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      Text('Chi tiết'),
                    ],
                  ),
                ),
                Form(
                  key: _formKeyTeamDescription,
                  child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      //maxLength: 100,
                      minLines: 1,
                      maxLines: 5,
                      validator: (value) {
                        if (value!.trim().length < 5) {
                          return 'Nhập ít nhất 5 ký tự';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_formKeyTeamDescription.currentState!.validate()) {
                          bloc.add(ChangeTeamDescriptionValueEvent(
                              newDescriptionValue: value.trim()));
                        }
                      }),
                )
              ]),
            ),
            actions: [
              Container(
                width: double.infinity,
                margin: new EdgeInsets.only(right: 15, left: 15, bottom: 15),
                child: FlatButton(
                  textColor: ArgonColors.white,
                  color: ArgonColors.warning,
                  onPressed: () {
                    if (_formKeyTeamDescription.currentState!.validate()) {
                      if (_formKeyTeamName.currentState!.validate()) {
                        bloc.add(ClickButtonCreate());
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 12, bottom: 12),
                      child: Text("Tạo",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0))),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
