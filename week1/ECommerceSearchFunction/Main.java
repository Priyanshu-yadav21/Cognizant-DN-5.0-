public class Main {

    public static void main(String[] args) {

        // Products for Linear Search
        Product[] products = {

                new Product(105, "Laptop", "Electronics"),
                new Product(102, "Shoes", "Fashion"),
                new Product(108, "Phone", "Electronics"),
                new Product(101, "Book", "Education"),
                new Product(110, "Watch", "Accessories")

        };

        System.out.println("===== LINEAR SEARCH =====");

        Product result1 = SearchAlgorithms.linearSearch(products, 108);

        if (result1 != null) {
            result1.display();
        } else {
            System.out.println("Product not found");
        }

        // Sorted array for Binary Search

        Product[] sortedProducts = {

                new Product(101, "Book", "Education"),
                new Product(102, "Shoes", "Fashion"),
                new Product(105, "Laptop", "Electronics"),
                new Product(108, "Phone", "Electronics"),
                new Product(110, "Watch", "Accessories")

        };

        System.out.println("===== BINARY SEARCH =====");

        Product result2 = SearchAlgorithms.binarySearch(sortedProducts, 108);

        if (result2 != null) {
            result2.display();
        } else {
            System.out.println("Product not found");
        }

    }
}