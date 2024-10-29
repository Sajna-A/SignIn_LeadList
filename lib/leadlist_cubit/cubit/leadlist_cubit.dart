import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:login_list/cubit/cubit/login_cubit.dart';
import 'package:login_list/MODEL/listmodelapi.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'leadlist_state.dart';

class LeadlistCubit extends Cubit<LeadlistState> {
  LeadlistCubit(this.context) : super(LeadlistInitial()) {
    leadlist();
  }

  BuildContext context;
  Future<void> leadlist() async {
    print("data");
    final token = await getToken();
    if (token != null) {
      print("token$token");
    } else
      () {
        print("token not found");
      };
    final String Url = "https://crm-beta-api.vozlead.in/api/v2/lead/lead_list/";
    final response = await http.get(
      Uri.parse(Url),
      headers: {"Authorization": "token $token"},
    );
    if (response.statusCode == 200) {
      print(response.body);
      final res = jsonDecode(response.body);
      final data = Listmodelapi.fromJson(res);
      emit(viewData(data: data));
    }
  }
}
