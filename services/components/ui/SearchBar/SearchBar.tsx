import { useState, useEffect, useRef } from "react";
import { Button } from "../Button/Button";
// import { CustomImage } from "../Images/Image";

interface Product {
  id: number;
  title: string;
  price: number;
  image: string;
  category: string;
}

export default function SearchBar() {
  const [query, setQuery] = useState("");
  const [results, setResults] = useState<Product[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [showResults, setShowResults] = useState(false);
  const [error, setError] = useState("");
  const searchRef = useRef<HTMLDivElement>(null);

  // Handle clicks outside of search results to close them
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (searchRef.current && !searchRef.current.contains(event.target as Node)) {
        setShowResults(false);
      }
    }

    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, []);

  // Debounced search function
  useEffect(() => {
    if (!query.trim()) {
      setResults([]);
      setShowResults(false);
      return;
    }

    const debounceTimeout = setTimeout(() => {
      searchProducts(query);
    }, 300);

    return () => clearTimeout(debounceTimeout);
  }, [query]);

  const searchProducts = async (searchQuery: string) => {
    try {
      setIsLoading(true);
      setError("");
      
      const response = await fetch("https://fakestoreapi.com/products");
      
      if (!response.ok) {
        throw new Error("Failed to fetch products");
      }
      
      const products: Product[] = await response.json();
      
      // Filter products based on search query
      const filteredProducts = products.filter((product) =>
        product.title.toLowerCase().includes(searchQuery.toLowerCase())
      );
      
      setResults(filteredProducts);
      setShowResults(true);
    } catch (err) {
      setError("Error fetching products. Please try again.");
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div ref={searchRef} className="w-full relative">
      <div className="relative">
        <input
          type="text"
          placeholder="Search products..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          onFocus={() => query.trim() && setShowResults(true)}
          className="w-full px-4 py-2 border border-secondary border-opacity-20 rounded-md pl-10 focus:outline-none focus:ring-2 focus:ring-primary"
        />
        <div className="absolute left-3 top-1/2 transform -translate-y-1/2 text-secondary">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            className="w-5 h-5"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
            />
          </svg>
        </div>
        {query && (
          <button
            onClick={() => setQuery("")}
            className="absolute right-3 top-1/2 transform -translate-y-1/2 text-secondary"
            aria-label="Clear search"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              className="w-5 h-5"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
          </button>
        )}
      </div>

      {/* Search Results Dropdown */}
      {showResults && (
        <div className="absolute z-50 mt-1 w-full bg-light rounded-md shadow-lg max-h-80 overflow-y-auto">
          {isLoading ? (
            <div className="p-4 text-center text-secondary">
              <div className="animate-spin w-6 h-6 border-2 border-primary border-t-transparent rounded-full mx-auto mb-2"></div>
              Loading...
            </div>
          ) : error ? (
            <div className="p-4 text-center text-danger">{error}</div>
          ) : results.length === 0 ? (
            <div className="p-4 text-center text-secondary">No products found</div>
          ) : (
            <ul className="py-1">
              {results.map((product) => (
                <li key={product.id} className="border-b border-light last:border-b-0">
                  <Button
                    onClick={() => {
                      // Handle product selection (e.g., navigate to product page)
                      console.log("Selected product:", product);
                      setShowResults(false);
                    }}
                    className="w-full text-left p-3 hover:bg-light flex items-center space-x-3"
                  >
                    <div className="w-10 h-10 flex-shrink-0 bg-white p-1 rounded">
                      {/* <CustomImag
                        src={product.image}
                        alt={product.title}
                        className="w-full h-full object-contain"
                      /> */}
                    </div>
                    <div className="flex-grow min-w-0">
                      <p className="text-secondary font-medium truncate">{product.title}</p>
                      <div className="flex justify-between items-center mt-1">
                        <span className="text-primary font-bold">${product.price.toFixed(2)}</span>
                        <span className="text-xs bg-secondary bg-opacity-10 text-secondary px-2 py-1 rounded-full">
                          {product.category}
                        </span>
                      </div>
                    </div>
                  </Button>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  );
}