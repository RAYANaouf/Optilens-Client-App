import 'package:flutter/material.dart';

class InvoiceItemData {
  final String title; // titre dynamique pour chaque item
  final double ttc;
  final double price;

  InvoiceItemData({
    required this.title,
    required this.ttc,
    required this.price,
  });
}

class InvoiceList extends StatelessWidget {
  final String globalTitle; // Titre global changeable
  final String label; // Label fixe pour tous les items de la page
  final Color priceColor; // Couleur fixe du prix pour tous les items
  final List<InvoiceItemData> items;

  const InvoiceList({
    super.key,
    required this.globalTitle,
    required this.label,
    required this.priceColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5), // fond gris clair
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre global
          if (globalTitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                globalTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
          // Liste des items
          ...items.map((item) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white, // couleur exacte des boxes Payment
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Partie gauche : label fixe + titre + TTC
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$label: ${item.title}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "TTC: ${item.ttc.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),

                  // Prix à droite avec couleur fixe
                  Text(
                    "${item.price.toStringAsFixed(2)} DA",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: priceColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
