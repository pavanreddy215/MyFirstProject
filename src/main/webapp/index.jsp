<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>NexusShop — Modern UI</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Poppins:wght@600;700&display=swap" rel="stylesheet">

<style>
:root {
    --bg: #0f172a;
    --primary: #ffffff;
    --accent: #6366f1;
    --accent2: #22c55e;
    --muted: #94a3b8;
    --glass: rgba(255,255,255,0.06);
    --border: rgba(255,255,255,0.1);
}

body {
    margin: 0;
    font-family: Inter;
    background: var(--bg);
    color: var(--primary);
}

/* HEADER */
header {
    position: sticky;
    top: 0;
    backdrop-filter: blur(10px);
    background: rgba(15,23,42,0.7);
    border-bottom: 1px solid var(--border);
}

.container {
    max-width: 1200px;
    margin: auto;
    padding: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.brand {
    font-weight: 700;
    font-size: 22px;
}

.accent {
    color: var(--accent);
}

/* HERO */
.hero {
    text-align: center;
    padding: 80px 20px;
    background: radial-gradient(circle, rgba(99,102,241,0.4), transparent);
}

.hero h1 {
    font-size: 48px;
    background: linear-gradient(to right, #6366f1, #22c55e);
    -webkit-background-clip: text;
    color: transparent;
}

/* GRID */
.grid {
    display: grid;
    gap: 20px;
    padding: 40px;
}

.products {
    grid-template-columns: repeat(auto-fit, minmax(250px,1fr));
}

/* CARD */
.card {
    background: var(--glass);
    border: 1px solid var(--border);
    border-radius: 16px;
    padding: 15px;
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-8px);
    box-shadow: 0 20px 40px rgba(0,0,0,0.5);
}

.card img {
    width: 100%;
    border-radius: 12px;
    transition: 0.3s;
}

.card:hover img {
    transform: scale(1.05);
}

/* BUTTON */
button {
    padding: 10px;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    background: linear-gradient(135deg,#6366f1,#22c55e);
    color: white;
    font-weight: 600;
}

button:hover {
    transform: translateY(-2px);
}

/* PRICE */
.price {
    font-weight: bold;
    margin-top: 10px;
}

/* SEARCH */
.search input {
    padding: 8px;
    border-radius: 20px;
    border: none;
    outline: none;
}
</style>
</head>

<body>

<header>
    <div class="container">
        <div class="brand">Nexus<span class="accent">Shop</span></div>
        <div class="search">
            <input type="text" id="searchInput" placeholder="Search..." />
        </div>
    </div>
</header>

<section class="hero">
    <h1>Premium Shopping Experience</h1>
    <p>Modern UI with smooth design</p>
</section>

<section class="grid products" id="products"></section>

<script>
const PRODUCTS = [
{ title:"iPhone 14", price:999, img:"https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb" },
{ title:"MacBook", price:1999, img:"https://images.unsplash.com/photo-1593642632823-8f785ba67e45" },
{ title:"Headphones", price:399, img:"https://images.unsplash.com/photo-1600185365483-26d7a4cc7519" },
{ title:"Shoes", price:150, img:"https://images.unsplash.com/photo-1542272604-787c3835535d" }
];

const grid = document.getElementById("products");

function render(list){
    grid.innerHTML = "";
    list.forEach(p=>{
        grid.innerHTML += `
        <div class="card">
            <img src="${p.img}" />
            <h3>${p.title}</h3>
            <div class="price">$${p.price}</div>
            <button>Add to Cart</button>
        </div>`;
    });
}

render(PRODUCTS);

// SEARCH
document.getElementById("searchInput").addEventListener("input", e=>{
    const q = e.target.value.toLowerCase();
    render(PRODUCTS.filter(p=>p.title.toLowerCase().includes(q)));
});
</script>

</body>
</html>
