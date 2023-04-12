part of '../gallery_view.dart';

class GalleryAppBarWidget extends StatelessWidget {
  const GalleryAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Text(
              (state is AuthLoggedInState)
                  ? "Welcome \n${state.userEntity.name}"
                  : "Welcome \n User",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeightManager.semiBold),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(right: 14.w),
          child: CircleAvatar(
            maxRadius: 33.w,
            backgroundImage: const AssetImage(AppAssets.profile),
          ),
        ),
      ],
    );
  }
}
