import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'StopwatchWidget.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:gsheets/gsheets.dart';


class Walkingpage extends StatefulWidget{
  const Walkingpage({super.key});

  @override
  State<Walkingpage> createState() => _WalkingpageState();
}

class _WalkingpageState extends State<Walkingpage> {
  List<String> names = [];
  String? user1;
  String? user2;
  final formKey = GlobalKey<FormState>();
  final _stopwatchKey = GlobalKey<StopwatchWidgetState>();
  final spreadsheetId = '1NU2KYajYr6Tn0CWFDuV8p-hAHohsAvRLRtdniJWPJmM';
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "gsheets-427704",
    "private_key_id": "baf5d3e03bc4796de6c35ad4d28fdb99366e0635",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCyC2crVrDVXVLV\nnLzwyXztKp+qcMiJ1MGpcIERHh5IVDdOTZMruyGUTISp1Vma8o0a2HMtGvSCmHz8\n/BnceRFacgprDu6WocgNI6VpB4qJnNG2RYSFEJwF/HEsUHhz/ZNNrjptkyevcyvy\nWLsu43VaB9WYKgzXyvwSx4Z6KBTMohyyHVeOmgOwQrcTBTmYMAtu6XNlCEUZ4i4J\nd42+FwFQIahs+PsP9JDJLyGjvfGhN/A35YuisXU6KHFgKHCPAuoXgFCrbO8zTh+c\nQ/zDSvHeznalbQJLKj6wuj3pfz86H+N1Rbi1mfU0YWBoV76wF772ox7tfUwOX1+R\nGamvtDsJAgMBAAECggEATNcwCRvKiONUlz2kq7UB9iexrjEr05Sfml2kTnt1rViv\nX9uKG1MRnHvju5qJKB7reD0XhE2AXoaqVtME5EraCvNx/J9+qEMdYFJUlr4688Zb\nGfPpzDYNaGX5gBsgyUqU0u9RZy4d8BJgUqEp9AQWByufayMm1NFVtlMnfjwjMedC\n0Z0WCqyojKWyQY0hSl8GU1/8JJz/Vq/b8i3rlOIBIzhhGSLkVRuNbLguReZd/Ozn\neV0dJc6tROM/puY9Flh2hVyEQYlhL84VrxkG32TQs1hyWiT7rQsQnu7cua3clOvB\nis2E7cpWb4cHeFrcPPVrNLKDl6grLpT9Hfgeont5cwKBgQDevdrdyHfj8DewgU5U\nKJftKNpQ3ZP3vObfzXAGmsHfTa1XwjpDYK+fySLjRr8J6kYH4VPHnA4EVSU0Nzue\nco/bawNhzR/MtSJ8pgXxTuLMlutphmPISv6Qhc4qVTsk8b25Nz6EB/yTws/X9TfZ\nfeyb8Ow3IqNPV1sUMLYEspAFcwKBgQDMoQh1Qn2itZUhLTSORXIkuSy0OHBQ0tFn\nPeP8uE86Gd1FWmxEyJcYmGstsgAdTDxjZpaz8E1rrRiYGO252EzfcFJluD226rJ/\n39uLTJ813Xg+kMDB96yXOmred9huTd2Aeoq3ulC2hxwkl51jviAlxKnpBrrYMTmU\nbBE4ucP+kwKBgGCqkIPT7oQTyndlhrLrcxPPuP+DSiYn6yKRq96R5zWcJnCBsHtx\nSIbV6bgtCdepvn7JAW0Ngt/Ke/zvQ4Z+PYSCKtOVDAnxSmhCPS3+iFs13DDNzBwu\nv8/E4jZpCuP7rdTl7tGqDamq0DzvBS/0gG0k378F304doT9f7H6ZZ/uVAoGAFM6r\nFYFVVR4xs9Xs6iqVmLZbnVe/0/gb4uugKypyo+3NWif/ql7bPl0BSPw4lsIRwenE\nmTduJ+zJ+21NfwBHkNDTEBTT8a2byPTyVg/MgKWsfHArqY2NtzLxev2kvFKem1na\nkSQY4PaMHgxsrJ/AlRaSUGemyCT5PeZfOe1pyJECgYEAyZnovWI5y+r27LYdBr34\nDjfFqGkwidsyx7f6J8S+cn5qKkoef84IR2NsP3di2o2nHDwiq4T5vXEVsrplQjkv\n4rgcaNhwTM40Q/5dDNiJH7AD33ZhCxYENaFa7Wa3qnkA+cFzEc+nu0OKPRGizevq\nzmw2KTp1DIJH6hlJX899ynM=\n-----END PRIVATE KEY-----\n",
    "client_email": "gsheets@gsheets-427704.iam.gserviceaccount.com",
    "client_id": "113280898924518748537",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-427704.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
  ''';
final gsheets = GSheets(_credentials);

  @override
  void initState(){
    super.initState();
    loadUsers();
  }

  void loadUsers() async{
    final rawData = await rootBundle.loadString("assets/users.csv");
    List<List<dynamic>> listdata = const CsvToListConverter().convert(rawData);
    setState(() {
      for(int i =0;i < listdata.length; i++){
        names.add(listdata[i][0] + " " +listdata[i][1]);
      }
    });
  }
   void submitForm(user1, user2, time) async{
    DateTime now = DateTime.now();
    String? date = now.toString();
    String end_time = DateFormat.Hms().format(now).toString();
    String start_time = DateFormat.Hms().format(now.subtract(Duration(milliseconds: time))).toString();

    final ss = await gsheets.spreadsheet(spreadsheetId);
    final sheet = await ss.worksheetByTitle('walks');
    await sheet!.values.appendRow(
    [date, start_time, end_time, user1, user2],
  );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select first walker!',
                  border: OutlineInputBorder(),
                ),
                value: user1,
                items: names.map((String user) {
                  return DropdownMenuItem<String>(
                    value: user,
                    child: Text(user),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    user1 = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a user';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select second walker!',
                  border: OutlineInputBorder(),
                ),
                value: user2,
                items: names.map((String user) {
                  return DropdownMenuItem<String>(
                    value: user,
                    child: Text(user),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    user2 = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a user';
                  }
                  return null;
                },
              ),
              const Padding(
              padding: EdgeInsets.all(16.0),
              ),
              StopwatchWidget(key:_stopwatchKey),
              ElevatedButton(
                onPressed: () {
                  submitForm(user1, user2, _stopwatchKey.currentState!.stopwatch.elapsedMilliseconds);
                  if (formKey.currentState!.validate()) {
                    String watchTime = _stopwatchKey.currentState?.returnFormattedText() ?? '00:00:000';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Submitted Walk for $user1 and $user2 for $watchTime'),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}