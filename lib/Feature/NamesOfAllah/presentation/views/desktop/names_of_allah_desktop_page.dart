import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Core/widgets/appbar/desktop/custom_app_bar_desktop.dart';
import 'package:Ajr/Feature/NamesOfAllah/data/models/name_of_allah_model.dart';
import 'package:Ajr/Feature/NamesOfAllah/data/repo/names_of_allah_repo.dart';
import 'package:Ajr/Feature/NamesOfAllah/presentation/manager/names_of_allah_cubit.dart';
import 'package:Ajr/Feature/NamesOfAllah/presentation/manager/names_of_allah_state.dart';

class NamesOfAllahDesktopPage extends StatefulWidget {
  const NamesOfAllahDesktopPage({super.key});

  @override
  State<NamesOfAllahDesktopPage> createState() =>
      _NamesOfAllahDesktopPageState();
}

class _NamesOfAllahDesktopPageState extends State<NamesOfAllahDesktopPage> {
  NameOfAllahModel? _selectedName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NamesOfAllahCubit(NamesOfAllahRepository())..loadNames(),
      child: Scaffold(
        appBar: const CustomAppBarDesktop(title: 'أسماء الله الحسنى'),
        body: BlocBuilder<NamesOfAllahCubit, NamesOfAllahState>(
          builder: (context, state) {
            if (state.status == NamesOfAllahStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            } else if (state.status == NamesOfAllahStatus.failure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else if (state.status == NamesOfAllahStatus.success) {
              // Auto-select first name if none selected
              if (_selectedName == null && state.names.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _selectedName = state.names.first;
                  });
                });
              }

              return Row(
                children: [
                  // Left Side - Names Grid
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.grey[50],
                      child: GridView.builder(
                        padding: const EdgeInsets.all(24),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.2,
                            ),
                        itemCount: state.names.length,
                        itemBuilder: (context, index) {
                          final name = state.names[index];
                          final isSelected = _selectedName?.id == name.id;
                          return _NameCardDesktop(
                            nameModel: name,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedName = name;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  // Right Side - Detail View
                  Expanded(
                    flex: 3,
                    child: _selectedName != null
                        ? _NameDetailView(nameModel: _selectedName!)
                        : const Center(
                            child: Text(
                              'اختر اسماً لعرض التفاصيل',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _NameCardDesktop extends StatefulWidget {
  final NameOfAllahModel nameModel;
  final bool isSelected;
  final VoidCallback onTap;

  const _NameCardDesktop({
    required this.nameModel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NameCardDesktop> createState() => _NameCardDesktopState();
}

class _NameCardDesktopState extends State<_NameCardDesktop> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.primary
                : _isHovered
                ? Colors.white
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isSelected
                  ? AppColors.primary
                  : _isHovered
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : Colors.grey[300]!,
              width: widget.isSelected ? 2 : 1,
            ),
            boxShadow: widget.isSelected || _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              widget.nameModel.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.isSelected
                    ? Colors.white
                    : _isHovered
                    ? AppColors.primary
                    : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NameDetailView extends StatelessWidget {
  final NameOfAllahModel nameModel;

  const _NameDetailView({required this.nameModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Name with decorative circle
              Text(
                nameModel.name,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontFamily: 'Amiri',
                ),
              ),

              // Decorative divider
              Container(
                height: 2,
                width: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.primary.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // Description
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  nameModel.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 2.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
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
