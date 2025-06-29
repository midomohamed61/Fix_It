class Review {
  final String image;
  final String reviewerName;
  final String date;
  final String comment;
  final int rating;

  Review({
    required this.image,
    required this.reviewerName,
    required this.date,
    required this.comment,
    this.rating = 5,
  });
}
