import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projeto/authentication/auth_service.dart';
import 'package:projeto/configs/app_settings.dart';
import 'package:flutter/foundation.dart';  // Import for kIsWeb
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';  // Import for handling web image data

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthService usuario;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;
  File? _image;
  Uint8List? _webImage;  // Uint8List to handle web image data
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _pass1Controller = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? pass1, pass2, currPass;

  @override
  void initState() {
    super.initState();
    usuario = AuthService();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    await usuario.fetchUserData();
    setState(() {
      isLoading = false;
    });
  }

  Future<File> convertImage () async {
    Uint8List imageInUnit8List = _webImage!;
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    return file;
  } 

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (kIsWeb) {
          // Handle web-specific image file
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _webImage = bytes;
          });
          _image = await convertImage();
        } else {
          // Handle mobile-specific image file
          setState(() {
            _image = File(pickedFile.path);
          });
          String url = await uploadFile(_image!);
          User? user = _auth.currentUser;
          user!.updatePhotoURL(url);
        }
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<String> uploadFile(File image) async {
    String downloadURL;
    String postId=DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child("images").child("post_$postId.jpg");
    await ref.putFile(image);
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> _handleUpdatePassword(String newPass, String currPass) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: currPass,
      );
      User? user = _auth.currentUser;
      user!.updatePassword(newPass);
      print('Password updated');
    } catch (e) {
    print(e);
    }
  }

/*   void _editarTelefone() async {
    String? novoTelefone = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return EditarTelefonePopup(
          telefoneAtual: categorias[index],
        );
      },
    );

    if (novoTelefone != null && novoTelefone.isNotEmpty) {
      setState(() {
        categorias[index] = novoTelefone;
      });
    }
  } */

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;
    if (kIsWeb && _webImage != null) {
      backgroundImage = MemoryImage(_webImage!);
    } else if (_image != null) {
      backgroundImage = FileImage(_image!);
    }

    return Scaffold(
      backgroundColor: AppSettings.getCorFundo(),
      appBar: AppBar(
        backgroundColor: AppSettings.getCorFundo(),
        iconTheme: IconThemeData(color: AppSettings.getCorTema())
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: backgroundImage,
                    backgroundColor: AppSettings.getCorSecundaria(),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: AppSettings.getCorTema().withOpacity(0.5)),
                      onPressed: _pickImage,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(usuario.nome, 
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppSettings.getCorTema(), fontSize: 16)),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: Text('Email',
                      style: TextStyle(color: AppSettings.getCorTema().withOpacity(0.5))),
                    trailing: Text(usuario.email,
                      style: TextStyle(
                        color: AppSettings.getCorTema(),
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                  ),
                  Divider(color: AppSettings.getCorTema()),
                  ListTile(
                    title: Text('Data de nascimento',
                      style: TextStyle(color: AppSettings.getCorTema().withOpacity(0.5))),
                    trailing: Text("",
                      style: TextStyle(
                        color: AppSettings.getCorTema(),
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                  ),
                  Divider(color: AppSettings.getCorTema()),
                  ListTile(
                    title: Text('Telefone',
                      style: TextStyle(color: AppSettings.getCorTema().withOpacity(0.5))),
                    trailing: usuario.celular != '' 
                    ? Text(usuario.celular,
                      style: TextStyle(
                        color: AppSettings.getCorTema(),
                        fontWeight: FontWeight.bold,
                        fontSize: 16))
                    : const Text(''),
                    /* onTap: () {
                      _editarTelefone();
                    }, */
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _currentPassController,
                    decoration: const InputDecoration(
                      labelText: 'Senha Atual',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        currPass = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _pass1Controller,
                    decoration: const InputDecoration(
                      labelText: 'Nova Senha',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if(value != null || value!.isNotEmpty){
                        if(value.length < 6){
                          return "A nova senha deve ter no mínimo 6 caracteres";
                        }
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        pass1 = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _pass2Controller,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar Nova Senha',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if(value != null || value!.isNotEmpty){
                        if(value != pass1){
                          return "As duas senhas devem ser iguais";
                        }
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        pass2 = value;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(AppSettings.getCorTema()),
                      minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
                      textStyle: WidgetStateProperty.all<TextStyle>(
                        const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    child: Text('Salvar Alterações', style: TextStyle(color: AppSettings.getCorSecundaria())),
                    onPressed: () {
                      if(currPass != "" && pass1 != "" && pass2 != "" && pass1 == pass2){  
                        _handleUpdatePassword(pass1!, currPass!);
                      }
                    },
                  ),
                ],
              ),)
            ),
    );
  }

  void _showEditDialog(BuildContext context, String field, String currentValue, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar $field'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/* class EditarTelefonePopup extends StatelessWidget {
  final User? user;

  EditarTelefonePopup({required this.user});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return AlertDialog(
      title: const Text('Editar número de telefone'),
      content: TextFormField(
        controller: controller,
        onChanged: (String? newValue) {
          user!.updatePhoneNumber(newValue);
        },
      ),
    );
  }
} */