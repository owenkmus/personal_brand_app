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

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'No se pudo enviar el correo';
    }
  }

  void _openWhatsApp(BuildContext context) async {
    final String phoneNumber = '573202499745';
    final String message =
        Uri.encodeComponent('Hola Cristian, me gustaría contactarte.');
    final Uri whatsappUri =
        Uri.parse('whatsapp://send?phone=$phoneNumber&text=$message');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'No se pudo abrir WhatsApp. Asegúrate de que esté instalado y que el número sea válido.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/Chris.png'),
              radius: 20,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              'Cristian Sosa',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                '¡Personal Brand App!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[300],
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              CircleAvatar(
                backgroundImage: AssetImage('assets/Chris.png'),
                radius: 70,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 25),
              Text(
                'Desarrollador de Aplicaciones y Gestor de Desarrollo Comercial, con sólida experiencia en la creación de soluciones innovadoras y en la dirección de estrategias de ventas. Mi enfoque integra habilidades técnicas y comerciales para generar resultados efectivos y duraderos.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30),
              Text(
                'Mis Habilidades:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[300],
                ),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildSkillCard('Desarrollo Web', Icons.code),
                  _buildSkillCard('App Móvil', Icons.phone_android),
                  _buildSkillCard('Gestión Comercial', Icons.business_center),
                  _buildSkillCard('Liderazgo', Icons.leaderboard),
                  _buildSkillCard('Ventas', Icons.sell),
                ],
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _sendEmail,
                    icon: Icon(Icons.mail_outline),
                    label: Text('Portafolio'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _openWhatsApp(context),
                    icon: Icon(Icons.message_outlined),
                    label: Text('Contáctame'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildSkillCard(String skill, IconData icon) {
    return Card(
      color: Colors.grey[900],
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.blue[300],
            ),
            SizedBox(height: 10),
            Text(
              skill,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
