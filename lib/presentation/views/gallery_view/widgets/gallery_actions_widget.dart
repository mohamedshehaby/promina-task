part of '../gallery_view.dart';

class GalleryActionsWidget extends StatelessWidget {
  const GalleryActionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.loginRoute, (_) => false);
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              width: 145.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppAssets.logoutIcon,
                    width: 28.w,
                  ),
                  Text(
                    AppStrings.logout,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              )),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return Dialog(
                    elevation: 0,
                    backgroundColor: Colors.white.withOpacity(.4),
                    child: Container(
                      height: 300.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 50.h, horizontal: 55.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              uploadImage(context, ImageSource.gallery);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.h,
                                ),
                                decoration: BoxDecoration(
                                    color: const Color(0xffEFD8F9),
                                    borderRadius: BorderRadius.circular(20.w)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image(
                                      image:
                                          const AssetImage(AppAssets.gallery),
                                      width: 32.w,
                                      height: 32.h,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      AppStrings.gallery,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    )
                                  ],
                                )),
                          ),
                          30.verticalSpace,
                          GestureDetector(
                            onTap: () async {
                              uploadImage(context, ImageSource.camera);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.h,
                                ),
                                decoration: BoxDecoration(
                                    color: const Color(0xffEBF6FF),
                                    borderRadius: BorderRadius.circular(20.w)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image(
                                      image: const AssetImage(AppAssets.camera),
                                      width: 42.w,
                                      height: 42.h,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      AppStrings.camera,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              width: 145.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AppAssets.uploadIcon, width: 28.w),
                  Text(
                    AppStrings.upload,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              )),
        ),
      ],
    );
  }

  uploadImage(BuildContext context, ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: imageSource);

    if (image != null) {
      Navigator.of(context).pop();
      final uploadImage = File(image.path);
      context.read<ImageBloc>().add(ImageUploadImageEvent(image: uploadImage));
    }
  }
}
