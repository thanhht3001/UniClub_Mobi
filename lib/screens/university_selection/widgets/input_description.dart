import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/university_selection/university_selection_state.dart';

import '../../../bloc/university_selection/university_selection_bloc.dart';
import '../../../bloc/university_selection/university_selection_event.dart';

class TextfieldInputDescription extends StatefulWidget {
  @override
  State<TextfieldInputDescription> createState() =>
      _TextfieldInputDescriptionState();
}

class _TextfieldInputDescriptionState extends State<TextfieldInputDescription> {
  final _formKeyDescription = GlobalKey<FormState>();

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
            "Giới Thiệu Về Bản Thân",
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
                        key: _formKeyDescription,
                        child: TextFormField(
                            // controller: TextEditingController()..text = state.poiReceive.address,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            maxLength: 250,
                            minLines: 1,
                            maxLines: 10,
                            validator: (value) {
                              if (value!.length < 50) {
                                return 'Nhập ít nhất 50 ký tự';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (_formKeyDescription.currentState!
                                  .validate()) {
                                bloc.add(ChangeDescriptionValue(
                                    newDescriptionValue: value));
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
