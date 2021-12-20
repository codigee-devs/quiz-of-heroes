part of 'styles.dart';

class TextStyles {
  static final quizConfirm = quizAnswers.copyWith(fontSize: FontSizes.quizConfirm);

  static final artefactInfoDescBold = TextStyle(
    color: Colors.black,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    height: 1.1,
  );

  static final artefactInfoDescThin = TextStyle(
    color: Colors.black,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  static const body1 = TextStyle(
    color: AppColors.white,
    fontSize: FontSizes.body1,
    fontWeight: FontWeight.w400,
  );
  static const button = TextStyle(
    color: AppColors.buttonText,
    fontSize: FontSizes.button,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.poppins,
  );

  static const baseButtonStyle = TextStyle(
    color: AppColors.buttonText,
    fontSize: FontSizes.baseButtonStyle,
    fontWeight: FontWeight.w900,
    fontFamily: AppFonts.poppins,
    letterSpacing: 1,
  );

  static const creditsCodigee = TextStyle(
    color: AppColors.artyClickOrange,
    fontSize: 35,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w800,
  );

  static const creditsHeadline = TextStyle(
    color: AppColors.introText,
    fontSize: 40,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w800,
  );

  static const creditsTitle = TextStyle(
    color: AppColors.introText,
    fontSize: 30,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
  );

  static const creditsWebsite = TextStyle(
    color: AppColors.smalt,
    fontSize: 30,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w800,
  );

  static const headline1 = TextStyle(
    color: AppColors.white,
    fontSize: FontSizes.headline1,
    fontWeight: FontWeight.w300,
  );

  static const heroName = TextStyle(
    color: AppColors.black,
    fontSize: FontSizes.heroName,
    fontWeight: FontWeight.bold,
  );

  static const heroStats = TextStyle(
    color: AppColors.black,
    fontSize: FontSizes.heroStats,
    fontWeight: FontWeight.bold,
  );
  static const homeButtonStyle = TextStyle(
    color: AppColors.buttonText,
    fontSize: FontSizes.homeButton,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.poppins,
    letterSpacing: 1,
  );
  static const homeGreenButton = TextStyle(
    color: AppColors.buttonText,
    fontSize: FontSizes.homeButton,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.poppins,
    letterSpacing: 1,
    shadows: [
      Shadow(
        color: AppColors.rubbyDuckyYellow,
        offset: Offset(0, 1),
        blurRadius: 1,
      )
    ],
  );

  static const quizAnswers = TextStyle(
    color: AppColors.buttonText,
    fontSize: 22,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
  );

  static const quizQuestion = TextStyle(
    color: AppColors.black,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.poppins,
  );

  static const resultBold = TextStyle(
    color: AppColors.black,
    fontSize: 24,
    fontWeight: FontWeight.w800,
    fontFamily: AppFonts.poppins,
  );

  static const resultNormal = TextStyle(
    color: AppColors.black,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.poppins,
  );

  static const subtitleShadowWhite = TextStyle(
    color: AppColors.white,
    fontSize: FontSizes.body1,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.poppins,
    shadows: [
      Shadow(
        color: AppColors.black,
        offset: Offset(0.2, 1.5),
        blurRadius: 1,
      )
    ],
  );

  static const subtitle1 =
      TextStyle(color: AppColors.white, fontSize: FontSizes.subTitle1, fontWeight: FontWeight.w400);

  static const introText = TextStyle(
    color: AppColors.introText,
    fontSize: 20,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
  );

  static const introHeadline = TextStyle(
    color: AppColors.introText,
    fontSize: 28,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w800,
  );

  static final outlinedWhite1 = TextStyle(
    fontFamily: AppFonts.poppins,
    color: AppColors.white,
    fontSize: FontSizes.headline1,
    fontWeight: FontWeight.w600,
    shadows: generateBorderTextByShadows(borderColor: AppColors.black, borderWidth: 1, precision: 10),
  );

  static final outlinedWhite2 = TextStyle(
    fontFamily: AppFonts.poppins,
    color: AppColors.white,
    fontSize: FontSizes.headline1,
    fontWeight: FontWeight.w600,
    shadows: generateBorderTextByShadows(borderColor: AppColors.black, borderWidth: 2, precision: 5),
  );

  static final blackAppBarTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    color: AppColors.white,
    fontSize: FontSizes.subTitle1,
    fontWeight: FontWeight.w600,
  );

  static const rankingText = TextStyle(
    color: AppColors.introText,
    fontSize: 20,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
  );

  static final quizArtefactCountWidget = TextStyle(
    color: Colors.black,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w800,
  );
}
