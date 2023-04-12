part of '../gallery_view.dart';

class GalleryGridWidget extends StatelessWidget {
  const GalleryGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (context, state) {
        if (state is GalleryLoadingState) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is GallerySuccessState) {
          final images = state.images;
          return Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 24.w,
                    mainAxisSpacing: 24.h),
                itemBuilder: (ctx, i) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 2),
                        ]),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.w)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.w),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: images[i],
                        ),
                      ),
                    ),
                  );
                }),
          ));
        } else if (state is GalleryFailureState) {
          return Expanded(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    state.failure.message,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                25.verticalSpace,
                ElevatedButton(
                    onPressed: () {
                      context.read<GalleryBloc>().add(GalleryGetGalleryEvent());
                    },
                    child: const Text('Try Again'))
              ],
            )),
          );
        }
        return Expanded(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.unknownError,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<GalleryBloc>().add(GalleryGetGalleryEvent());
                  },
                  child: const Text('Try Again'))
            ],
          )),
        );
      },
    );
  }
}
