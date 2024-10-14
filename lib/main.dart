import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importar el paquete url_launcher
import 'package:video_player/video_player.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cristian Sosa MP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoController;
  //bool _showText = false; // Controla la aparición del texto

  @override
  void initState() {
    super.initState();

    // Inicializar el controlador de video
    _videoController = VideoPlayerController.asset('assets/IntroCris.mp4')
      ..initialize().then((_) {
        setState(() {
          _videoController.play();
          _videoController.setLooping(false);
        });
      }).catchError((error) {
        print("Error loading video: $error");
      });

    // Mostrar el texto después de 9 segundos
    /*Timer(const Duration(seconds: 9), () {
      setState(() {
        _showText = true;
      });
    });*/

    // Redirigir a la pantalla principal después de 10 segundos
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mostrar el video
            if (_videoController.value.isInitialized)
              AspectRatio(
                aspectRatio: 478 / 850, // Mantener la relación de aspecto
                child: VideoPlayer(_videoController),
              )
            else
              const CircularProgressIndicator(),
            const SizedBox(height: 20),
            // Mostrar el texto después de 14 segundos
            /*if (_showText)
              const Text(
                'Innovando soluciones,\nimpulsando negocios.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Peso de la fuente diferente
                  fontStyle: FontStyle.italic, // Estilo de fuente cursiva
                  color: Color.fromARGB(255, 180, 19, 19), // Color diferente
                  fontFamily:
                      'Roboto', // Tipo de letra diferente (puedes cambiarlo por la fuente que desees)
                  height: 1.5, // Espaciado entre líneas
                ),
                textAlign: TextAlign.center, // Centrando el texto
              ),*/
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'sales1@myasofty.com',
      query:
          'subject=Portafolio&body=Hola, me gustaría saber más sobre tu portafolio.',
    );

    print('Intentando abrir: $emailUri'); // Imprimir la URI para depuración

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('No se pudo enviar el correo: $emailUri');
      throw 'No se pudo enviar el correo';
    }
  }

  void _openWhatsApp(BuildContext context) async {
    final String phoneNumber = '573202499745'; // El número sin "+"
    final String message =
        Uri.encodeComponent('Hola Cristian, me gustaría contactarte.');
    final Uri whatsappUri =
        Uri.parse('whatsapp://send?phone=$phoneNumber&text=$message');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      print(
          'No se pudo abrir WhatsApp. Asegúrate de que esté instalado y que el número sea válido.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'No se pudo abrir WhatsApp. Asegúrate de que esté instalado y que el número sea válido.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/Chris.png'),
              radius: 20,
            ),
            SizedBox(width: 10),
            Text('Cristian Sosa'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '¡Personal Brand App!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              CircleAvatar(
                backgroundImage: AssetImage('assets/Chris.png'),
                radius: 60,
              ),
              SizedBox(height: 20),
              Text(
                'Desarrollador de Aplicaciones y Gestor de Desarrollo Comercial,'
                'con sólida experiencia en la creación de soluciones innovadoras y en la dirección '
                'de estrategias de ventas. Mi enfoque integra habilidades técnicas y comerciales'
                'para generar resultados efectivos y duraderos.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Mis Habilidades:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  _buildSkillCard('Desarrollo Web', Icons.code),
                  _buildSkillCard('App Móvil', Icons.phone_android),
                  _buildSkillCard('Gestión Comercial', Icons.business_center),
                  _buildSkillCard('Liderazgo', Icons.leaderboard),
                  _buildSkillCard('Ventas', Icons.sell),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _sendEmail,
                    icon: Icon(Icons.mail),
                    label: Text('Portafolio'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () =>
                        _openWhatsApp(context), // Pasar el contexto
                    icon: Icon(Icons.message),
                    label: Text('Contáctame'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCard(String skill, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              skill,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
