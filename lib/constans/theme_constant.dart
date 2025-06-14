  import 'package:flutter/material.dart';

  class AppTheme {
    // Primary Green Theme Colors
    static const Color primaryGreen = Color(0xFF3B8C6E);
    static const Color primaryGreenLight = Color(0xFF5FAF91);
    static const Color primaryGreenDark = Color(0xFF266B50);
    
    // Accent Colors
    static const Color accentOrange = Color(0xFFF5A623);
    static const Color accentPurple = Color(0xFF9B51E0);
    static const Color accentBlue = Color(0xFF4A90E2);
    
    // Neutral Colors
    static const Color neutralWhite = Color(0xFFFFFFFF);
    static const Color neutralGrey = Color(0xFFF5F5F5);
    static const Color neutralDarkGrey = Color(0xFF9E9E9E);
    static const Color neutralBlack = Color(0xFF333333);
    
    // Gradient for cards and backgrounds
    static const Gradient greenGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [primaryGreenLight, primaryGreen],
    );
    
    static const Gradient accentGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [accentOrange, Color(0xFFFA8E22)],
    );
    
    // Text Styles
    static const TextStyle headingStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: neutralBlack,
    );
    
    static const TextStyle subheadingStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: neutralBlack,
    );
    
    static const TextStyle bodyStyle = TextStyle(
      fontSize: 14,
      color: neutralBlack,
    );
    
    static const TextStyle smallStyle = TextStyle(
      fontSize: 12,
      color: neutralDarkGrey,
    );
    
    // Button Styles
    static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: primaryGreen,
      foregroundColor: neutralWhite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
    
    static final ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
      foregroundColor: primaryGreen,
      side: const BorderSide(color: primaryGreen),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
    
    // Card Decoration
    static final BoxDecoration cardDecoration = BoxDecoration(
      color: neutralWhite,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
    
    static final BoxDecoration gradientCardDecoration = BoxDecoration(
      gradient: greenGradient,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  } 