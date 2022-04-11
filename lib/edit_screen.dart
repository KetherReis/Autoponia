import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ava_autoponia/screen2.dart';

import 'components/custom_button.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}
class _EditScreenState extends State<EditScreen> {


  final ImagePicker _picker = ImagePicker();

  var title;
  var subtitle;
  var description;
  var mode;
  var imageName = "img_plant";
  var storage = FirebaseStorage.instance;

  late List<DropdownMenuItem<String>> _dropDownMode;
  var _selectedMode = 'Modo Manual';
  var _modeItems = <String>[
    'Modo Manual',
    'Modo Automático',

  ];

  _initDropDowns() {
    _dropDownMode = _modeItems
        .map((String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ))
        .toList();
  }
  @override
  void initState() {
    super.initState();
    _initDropDowns();
  }


  File? _image;

  Future _getImage(ImageSource imageSource) async {
    PickedFile? _imageFile;
    _imageFile = await _picker.getImage(source: imageSource);
    if (_imageFile != null) {
      setState(() {
        _image = File(_imageFile!.path);
      });
      //uploadPic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
        children: <Widget>[
       Expanded(
        child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  _openBottomSheet(context);
                },
                child: _image == null
                    ? const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  //backgroundImage: NetworkImage(avatarUrl),
                )
                    : CircleAvatar(
                  radius: 100,
                  backgroundImage: FileImage(_image!),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  _openBottomSheet(context);
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(4)),
                child: const Text(
                  'Alterar Foto',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              onChanged: (value){
                title = value;
              },
              decoration: const InputDecoration(
                labelText: 'Titulo *',
                hintText: 'Digite o título aqui',
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              onChanged: (value){
                subtitle = value;
              },
              decoration: const InputDecoration(
                labelText: 'Espécie *',
                hintText: 'Digite a espécie aqui',
              ),

            ),
            const SizedBox(height: 15),
            TextFormField(
              onChanged: (value){
                description = value;
              },
              decoration: const InputDecoration(
                labelText: 'Descrição *',
                hintText: 'Digite a descrição aqui',
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Operação do Irrigador',
            ),
            DropdownButton(
              isExpanded: true,
              value: _selectedMode,
              //hint: ,
              onChanged: (String? value) {
                setState(() {
                  _selectedMode = value!;
                  mode = value;
                });
              },
              items: _dropDownMode,
            ),
            const SizedBox(height: 15),
            CustomButton(
              onPressed: () {
                updateProfile();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Screen2()));
              },
              text: 'Atualizar dados',
            ),
          ],
        ),
      ),
    ),
    ),
       ),
    ]
    ),
    );
  }

  _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.camera,
                  size: 20,
                ),
                title: const Text(
                  'Tirar Foto',
                  style: TextStyle(
                    color: Color(0xff4a4a4a),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  size: 20,
                ),
                title: const Text(
                  'Escolher da Galeria',
                  style: TextStyle(
                    color: Color(0xff4a4a4a),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.gallery);
                },
              ),
            ],
          );
        });
  }

  Future<void> updateProfile() async{
    TaskSnapshot snapshot = await storage
        .ref()
        .child("images/$imageName")
        .putFile(_image!);
    final String downloadUrl =
    await snapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection('autoponia').doc(
        'josue').update({'title': title, 'subtitle': subtitle, 'description': description, 'mode': mode, "url": downloadUrl});
  }
}
