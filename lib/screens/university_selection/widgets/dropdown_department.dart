import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicec_mobi/bloc/university_selection/university_selection_bloc.dart';

import '../../../bloc/university_selection/university_selection_event.dart';
import '../../../bloc/university_selection/university_selection_state.dart';
import '../../../models/entities/department/department_model.dart';

class DropdownDepartment extends StatefulWidget {
  @override
  State<DropdownDepartment> createState() => _DropdownDepartmentState();
}

class _DropdownDepartmentState extends State<DropdownDepartment> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    UniversitySelectionBloc bloc =
        BlocProvider.of<UniversitySelectionBloc>(context);
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Trường Ngành Học:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              width: size.width * 0.6,
              height: 30, // 50
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: BlocBuilder<UniversitySelectionBloc,
                      UniversitySelectionState>(
                  bloc: bloc,
                  builder: (context, state) {
                    int dropdownValue = state.dropdownNewValueDep;
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        alignment: Alignment.centerLeft,
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                        onChanged: (int? newValue) {
                          bloc.add(ChangeDropdownValueDep(newValue: newValue!));
                        },
                        items: state.listDepartment.map<DropdownMenuItem<int>>(
                            (DepartmentModel value) {
                          return DropdownMenuItem<int>(
                            value: value.id,
                            child: Center(
                              child: Container(
                                  width: size.width * 0.55,
                                  // height: size.height * 0.15,
                                  child: Text("${value.name} - ${value.departmentCode}" 
                                  // value.name +
                                  //     " - " +
                                  //     value.departmentCode
                                      )),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
