import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'event_data.dart';
import 'links_controller.dart';

class ResponsiveLanding extends StatelessWidget {
  const ResponsiveLanding({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Ajuste de breakpoint para asegurar que el contenido detallado quepa bien
    final bool isDesktop = size.width > 1050;

    return Scaffold(
      body: Stack(
        children: [
          // --- CAPA 1: IMAGEN DE FONDO (TRACTOCAMIÓN) ---
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('assets/images/background_truck.png'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // --- CAPA 2: FILTRO OSCURO GRADIENT PARA TEXTO ---
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),

          // --- CAPA 3: CONTENIDO ---
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1300),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40),
                child: isDesktop 
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTextSection(isDesktop),
                        const SizedBox(width: 50),
                        _buildInfoCard(isDesktop),
                      ],
                    )
                  : Column(
                      children: [
                        _buildTextSection(isDesktop),
                        const SizedBox(height: 40),
                        _buildInfoCard(isDesktop),
                      ],
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sección Izquierda: Títulos y Llamado a la acción
  Widget _buildTextSection(bool isDesktop) {
    return Expanded(
      flex: isDesktop ? 6 : 0,
      child: Column(
        crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(
            EventData.subtitle, 
            style: GoogleFonts.oswald(
              color: Colors.redAccent, 
              fontSize: isDesktop ? 22 : 18, 
              letterSpacing: 3, 
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 20),
          Text(
            EventData.title, 
            textAlign: isDesktop ? TextAlign.left : TextAlign.center, 
            style: GoogleFonts.playfairDisplay(
              color: Colors.white, 
              fontSize: isDesktop ? 60 : 38, 
              fontWeight: FontWeight.bold, 
              height: 1.1
            )
          ),
          const SizedBox(height: 25),
          Text(
            EventData.mainQuestion, 
            textAlign: isDesktop ? TextAlign.left : TextAlign.center, 
            style: GoogleFonts.inter(
              color: Colors.white70, 
              fontSize: 22, 
              fontWeight: FontWeight.w300
            )
          ),
          const SizedBox(height: 50),
          _buildActionButtons(isDesktop),
        ],
      ),
    );
  }

  // Sección Derecha: Tarjeta de Beneficios Detallados (Información de la imagen 2)
 Widget _buildInfoCard(bool isDesktop) {
  return Expanded(
    flex: isDesktop ? 4 : 0,
    child: ClipRRect( // Necesario para que el blur no se salga de las esquinas
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // El efecto de desenfoque
        child: Container(
          padding: const EdgeInsets.all(35),
          decoration: BoxDecoration(
            // Usamos .withValues para cumplir con el estándar 2026
            color: Colors.white.withValues(alpha: 0.08), 
            borderRadius: BorderRadius.circular(25), 
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("BENEFICIOS CLAVE"),
              ...EventData.tools.map((item) => _bulletItem(item)),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: Colors.white24, thickness: 1),
              ),
              _sectionTitle("ANÁLISIS DE RENTABILIDAD"),
              ...EventData.analysis.map((item) => _bulletItem(item)),
              const SizedBox(height: 20),
              Text(
                "Toma decisiones basadas en datos día a día.",
                style: GoogleFonts.inter(
                  color: Colors.greenAccent, 
                  fontWeight: FontWeight.bold, 
                  fontStyle: FontStyle.italic
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        text, 
        style: GoogleFonts.inter(
          color: Colors.redAccent, 
          fontWeight: FontWeight.bold, 
          fontSize: 14, 
          letterSpacing: 2
        )
      ),
    );
  }

  Widget _bulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text, 
              style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.3)
            )
          ),
        ],
      ),
    );
  }

  // Botones de Redes y Registro
  Widget _buildActionButtons(bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 380,
          height: 70,
          child: ElevatedButton(
            onPressed: () => LinksController.openUrl(LinksController.whatsappUrl),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366), // Color oficial WhatsApp
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              shadowColor: Colors.greenAccent.withOpacity(0.4),
            ),
            child: const Text(
              "INSCRIBIRME AL WEBINAR", 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1)
            ),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          "CONÓCENOS EN",
          style: GoogleFonts.inter(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => LinksController.openUrl(LinksController.facebookUrl), 
              icon: const Icon(Icons.facebook, color: Colors.white, size: 40)
            ),
            const SizedBox(width: 30),
            IconButton(
              onPressed: () => LinksController.openUrl(LinksController.youtubeUrl), 
              icon: const Icon(Icons.play_circle_fill, color: Colors.white, size: 40)
            ),
          ],
        )
      ],
    );
  }
}