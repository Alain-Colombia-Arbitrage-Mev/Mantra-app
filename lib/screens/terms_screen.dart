import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ScreenNav(
                  title: 'Términos y Condiciones',
                  showBack: true,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                  child: Column(
                    children: [
                      // ── Content card ─────────────────────────────────
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.surfaceBorderLight),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MANTRAS · Términos de Uso',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Center(
                              child: Text(
                                'Última actualización: Marzo 2026',
                                style: GoogleFonts.urbanist(
                                  fontSize: 13,
                                  color: const Color(0x60FFFFFF),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            _Section(
                              number: '1.',
                              title: 'Aceptación de Términos',
                              body:
                                  'Al acceder y utilizar la aplicación MANTRAS, usted acepta quedar vinculado por estos Términos de Uso. Si no está de acuerdo con alguna parte de estos términos, no podrá acceder al servicio. El uso continuo de la aplicación después de cualquier modificación constituye la aceptación de los nuevos términos.',
                            ),
                            const SizedBox(height: 20),
                            _Section(
                              number: '2.',
                              title: 'Contenido y Propiedad Intelectual',
                              body:
                                  'Todo el contenido disponible en MANTRAS, incluyendo pero no limitado a meditaciones guiadas, frecuencias sonoras, mantras y materiales audiovisuales, es propiedad exclusiva de MANTRAS o de sus licenciantes. Queda expresamente prohibida la reproducción, distribución o modificación de cualquier contenido sin autorización escrita previa.',
                            ),
                            const SizedBox(height: 20),
                            _Section(
                              number: '3.',
                              title: 'Sesiones Privadas & Pagos',
                              body:
                                  'Las sesiones privadas con guías certificados requieren pago previo y están sujetas a disponibilidad. Los pagos son procesados de forma segura a través de proveedores certificados. Las cancelaciones realizadas con menos de 24 horas de antelación no son reembolsables. MANTRAS se reserva el derecho de modificar las tarifas con previo aviso de 30 días.',
                            ),
                            const SizedBox(height: 20),
                            _Section(
                              number: '4.',
                              title: 'Privacidad & Datos',
                              body:
                                  'MANTRAS recopila y procesa datos personales de conformidad con las leyes de protección de datos aplicables. Sus datos de meditación, preferencias y registros de sesión son almacenados de forma cifrada. No vendemos sus datos a terceros. Puede solicitar la eliminación de su cuenta y datos en cualquier momento desde la configuración de la aplicación.',
                            ),
                            const SizedBox(height: 20),
                            _Section(
                              number: '5.',
                              title: 'Suscripción & Facturación',
                              body:
                                  'La suscripción Pro de MANTRAS se renueva automáticamente al final de cada período de facturación. Puede cancelar su suscripción en cualquier momento desde la configuración de su cuenta o desde la tienda de aplicaciones correspondiente. La cancelación será efectiva al final del período de facturación activo. No se emiten reembolsos por períodos parciales de suscripción.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // ── CTA ───────────────────────────────────────────
                      GestureDetector(
                        onTap: () {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: AppGradients.primaryButton,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                LucideIcons.check,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Acepto los Términos',
                                style: GoogleFonts.urbanist(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String number;
  final String title;
  final String body;

  const _Section({
    required this.number,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number ',
              style: GoogleFonts.urbanist(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryLight,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: GoogleFonts.urbanist(
            fontSize: 13,
            color: const Color(0xCCFFFFFF),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
