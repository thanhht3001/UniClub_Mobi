import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:unicec_mobi/bloc/university_selection/university_selection_event.dart';

import '../../../bloc/university_selection/university_selection_bloc.dart';
import '../../../bloc/university_selection/university_selection_state.dart';

class DateOfBirth extends StatefulWidget {
  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UniversitySelectionBloc bloc =
        BlocProvider.of<UniversitySelectionBloc>(context);
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ngày Sinh:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            height: size.height * 0.1,
            child: BlocBuilder<UniversitySelectionBloc,
                    UniversitySelectionState>(
                bloc: bloc,
                builder: (context, state) {
                  return Center(
                      child: TextField(
                    controller: dateInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
                        ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //
                        bloc.add(ChangeDOBValue(newDOBValue: formattedDate));

                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ));
                }))
      ],
    );
  }
}
