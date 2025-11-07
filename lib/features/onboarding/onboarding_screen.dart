import 'package:drivenext/app/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:drivenext/app/theme/colors.dart';
import 'package:drivenext/app/theme/typography.dart';
import '../../../app/router/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      title: 'Аренда автомобилей',
      subtitle: 'Открой для себя удобный и доступный способ передвижения',
      image: 'assets/images/onboard_1.svg',
      fullWidth: true,
    ),
    _OnboardingData(
      title: 'Безопасно и удобно',
      subtitle: 'Арендуй автомобиль и наслаждайся его удобством',
      image: 'assets/images/onboard_2.svg',
      fullWidth: false,
    ),
    _OnboardingData(
      title: 'Лучшие предложения',
      subtitle: 'Выбирай понравившееся среди сотен доступных автомобилей',
      image: 'assets/images/onboard_3.svg',
      fullWidth: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      setState(() => _currentPage++);
    } else {
      context.go(AppRoutes.login);
    }
  }

  void _skip() => context.go(AppRoutes.login);

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 84),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: page.fullWidth
                      ? SvgPicture.asset(
                          page.image,
                          key: ValueKey(page.image),
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: SvgPicture.asset(
                            page.image,
                            key: ValueKey(page.image),
                            width: 320,
                            height: 280,
                            fit: BoxFit.contain,
                          ),
                        ),
                ),

                const SizedBox(height: 64),

                Container(
                  key: ValueKey(page.title),
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(page.title, style: AppTypography.h2),
                      const SizedBox(height: 24),
                      Text(
                        page.subtitle,
                        style: AppTypography.h3.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 64),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildIndicator(),
                          ElevatedButton(
                            onPressed: _nextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              minimumSize: const Size(120, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              _currentPage == _pages.length - 1
                                  ? 'Поехали'
                                  : 'Далее',
                              style: AppTypography.h3.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Positioned(
              top: 16,
              right: 24,
              child: AppTextButton(text: 'Пропустить', onPressed: _skip),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_pages.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 40 : 16,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.indicatorGray,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}

class _OnboardingData {
  final String title;
  final String subtitle;
  final String image;
  final bool fullWidth;

  const _OnboardingData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.fullWidth,
  });
}
