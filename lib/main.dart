import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade100),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/comments': (context) => const CommentsScreen(),
        '/settings': (context) => const ProductFormScreen(),
      },
    );
  }
}

// Pantalla de bienvenida con degradado y botón para ir al Login
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color softPurple = const Color.fromRGBO(155, 138, 233, 1);
    final Color gradientStart = Colors.deepPurple.shade50;
    final Color gradientEnd = Colors.deepPurple.shade200;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Bienvenida Gianella',
                  style: TextStyle(
                    color: softPurple,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: softPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Pantalla de Login sin flecha atrás y navegación sin historial al MainScreen
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    final Color softPurple = const Color.fromRGBO(155, 138, 233, 1);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Iniciar Sesión'),
        backgroundColor: Colors.deepPurple.shade100,
        foregroundColor: softPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade200,
                      foregroundColor: softPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      // Navegación sin historial para evitar volver al login o bienvenida
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/main',
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Pantalla principal sin flecha atrás y título personalizado
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color softPurple = const Color.fromRGBO(155, 138, 233, 1);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bienvenida Gianella'),
        backgroundColor: Colors.deepPurple.shade100,
        foregroundColor: softPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customStyledButton(
                context,
                label: 'Comentarios',
                onTap: () {
                  Navigator.pushNamed(context, '/comments');
                },
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(height: 20),
              customStyledButton(
                context,
                label: 'Settings',
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(height: 20),
              customStyledButton(
                context,
                label: 'Logout',
                onTap: () {
                  // Logout: regresa a bienvenida y elimina historial
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
                borderRadius: BorderRadius.circular(12),
                isLogout: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Botón personalizado
Widget customStyledButton(BuildContext context,
    {required String label,
    required VoidCallback onTap,
    double height = 50,
    BorderRadius borderRadius = BorderRadius.zero,
    bool isLogout = false}) {
  final Color mainColor = Colors.deepPurple.shade300;
  final Color backgroundColor = isLogout
      ? mainColor.withAlpha((0.15 * 255).round())
      : Colors.deepPurple.shade50;

  return InkWell(
    onTap: onTap,
    borderRadius: borderRadius,
    child: Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(color: mainColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: mainColor.withAlpha((0.15 * 255).round()),
            offset: const Offset(0, 3),
            blurRadius: 7,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: mainColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: mainColor,
            size: 20,
          ),
        ],
      ),
    ),
  );
}

// Pantalla de Comentarios
class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> comments = [
      'Holii este es mi primer comentario',
      '¿Aprobarás el curso?',
      '¿Cómo navegar en esta mini app?',
      '¿Otra pregunta de esta sección?',
      '¿Cuántas veces entraste?',
      'WIIIIIIIIIIIIIIIIIIII',
      '¿Qué hace la sección Comentarios?',
      'WAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
      'wiwiiwiwiwiiwiwiwiiwiw',
      '¡AYUDAAAAAAAA!',
      'La última pregunta xd',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comentarios'),
        backgroundColor: Colors.deepPurple.shade100,
        foregroundColor: const Color.fromRGBO(155, 138, 233, 1),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.comment, color: Colors.deepPurple),
              title: Text(
                comments[index],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Pantalla para Registrar Productos
class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void _registerProduct() {
    final name = nameController.text.trim();
    final desc = descController.text.trim();
    final price = priceController.text.trim();

    if (name.isNotEmpty && desc.isNotEmpty && price.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto "$name" registrado.')),
      );
      nameController.clear();
      descController.clear();
      priceController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor llena todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color softPurple = const Color.fromRGBO(155, 138, 233, 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Producto'),
        backgroundColor: Colors.deepPurple.shade100,
        foregroundColor: softPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre del producto',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _registerProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 208, 193, 235),
                    foregroundColor: softPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
