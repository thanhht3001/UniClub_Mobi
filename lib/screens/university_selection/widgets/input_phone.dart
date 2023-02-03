import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/university_selection/university_selection_state.dart';

import '../../../bloc/university_selection/university_selection_bloc.dart';
import '../../../bloc/university_selection/university_selection_event.dart';

class TextfieldInputPhone extends StatefulWidget {
  @override
  State<TextfieldInputPhone> createState() => _TextfieldInputPhoneState();
}

class _TextfieldInputPhoneState extends State<TextfieldInputPhone> {
  final _formKeyPhone = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UniversitySelectionBloc bloc =
        BlocProvider.of<UniversitySelectionBloc>(context);
    var size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Số Điện Thoại:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: size.width,
            child:
                BlocBuilder<UniversitySelectionBloc, UniversitySelectionState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return Form(
                        key: _formKeyPhone,
                        child: TextFormField(
                            // controller: TextEditingController()..text = state.poiReceive.address,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            maxLength: 10,
                            minLines: 1,
                            //maxLines: 3,
                            validator: (value) {
                              if (value!.length < 10) {
                                return 'Nhập ít nhất 10 ký tự';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (_formKeyPhone.currentState!.validate()) {
                                bloc.add(
                                    ChangePhoneValue(newPhoneValue: value));
                              }
                              //   state.poiReceive.address = value;
                            }),
                      );
                    }),
          )
        ],
      ),
    );
  }
}
