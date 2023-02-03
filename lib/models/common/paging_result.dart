class PagingResult<T> {
  int currentPage;
  int totalPages;
  int pageSize;
  int totalCount;
  bool hasNext;
  bool hasPrevious;
  List<T> items;

  PagingResult(
      {required this.currentPage,
      required this.totalPages,
      required this.pageSize,
      required this.totalCount,
      required this.hasNext,
      required this.hasPrevious,
      required this.items});

  factory PagingResult.fromJson(
      Map<String, dynamic> json, Function fromJsonModel) {
    if (json == null) throw Exception("Json paging model cannot null");
    final itemsMap = json['items'].cast<Map<String, dynamic>>();
    int currentPage = json['current_page'];
    int totalPages = json['total_pages'];
    int pageSize = json['page_size'];
    int totalCount = json['total_count'];
    bool hasNext = json['has_next'];
    bool hasPrevious = json['has_previous'];
    List<T> items =
        List<T>.from(itemsMap.map((itemsJson) => fromJsonModel(itemsJson)));
    return PagingResult(
        currentPage: currentPage,
        totalPages: totalPages,
        pageSize: pageSize,
        totalCount: totalCount,
        hasNext: hasNext,
        hasPrevious: hasPrevious,
        items: items);
  }
}
