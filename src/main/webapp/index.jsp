<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>NexusShop</title>

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">

<!-- Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root{
    --primary:#6c63ff;
    --secondary:#00c9a7;
    --bg:#f4f6fb;
    --card:#fff;
    --text:#1f2937;
    --muted:#6b7280;
    --green:#16a34a;
}

body{
    margin:0;
    font-family:Roboto;
    background:var(--bg);
}

/* HEADER */
header{
    background:linear-gradient(90deg,var(--primary),var(--secondary));
    color:white;
    padding:10px 20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.search input{
    width:300px;
    padding:8px;
    border:none;
    border-radius:4px;
}

.header-icons{
    display:flex;
    gap:20px;
    align-items:center;
    cursor:pointer;
}

.counter{
    background:white;
    color:black;
    border-radius:50%;
    padding:2px 6px;
    font-size:12px;
}

/* CATEGORY */
.categories{
    display:flex;
    gap:20px;
    background:white;
    padding:10px;
    border-bottom:1px solid #ddd;
}

.cat{
    cursor:pointer;
    color:var(--muted);
}

.cat.active{
    color:var(--primary);
    font-weight:bold;
}

/* GRID */
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(220px,1fr));
    gap:15px;
    padding:15px;
}

/* CARD */
.card{
    background:white;
    padding:12px;
    border-radius:8px;
    transition:0.2s;
}

.card:hover{
    box-shadow:0 4px 15px rgba(0,0,0,0.15);
}

.card img{
    width:100%;
    height:160px;
    object-fit:contain;
}

.title{
    font-size:14px;
    margin:8px 0;
}

.price{
    font-weight:bold;
}

.old{
    text-decoration:line-through;
    color:var(--muted);
    font-size:12px;
}

.rating{
    background:var(--green);
    color:white;
    padding:2px 6px;
    font-size:12px;
    border-radius:3px;
}

.actions{
    display:flex;
    justify-content:space-between;
    margin-top:8px;
}

button{
    background:var(--primary);
    color:white;
    border:none;
    padding:6px 10px;
    border-radius:4px;
    cursor:pointer;
}

/* SIDEBAR */
.sidebar{
    position:fixed;
    right:-350px;
    top:0;
    width:320px;
    height:100%;
    background:white;
    transition:0.3s;
    padding:15px;
    box-shadow:-2px 0 10px rgba(0,0,0,0.2);
}

.sidebar.active{
    right:0;
}

.back{
    cursor:pointer;
    font-weight:bold;
}

.wish.active i{
    color:red;
}
</style>
</head>

<body>

<header>
<h2>NexusShop</h2>

<div class="search">
<input type="text" id="search" placeholder="Search products...">
</div>

<div class="header-icons">
<div onclick="toggleWishlist()">
<i class="fa-solid fa-heart"></i>
<span class="counter" id="wishCount">0</span>
</div>

<div onclick="toggleCart()">
<i class="fa-solid fa-cart-shopping"></i>
<span class="counter" id="cartCount">0</span>
</div>
</div>
</header>

<!-- CATEGORY -->
<div class="categories" id="categories"></div>

<!-- PRODUCTS -->
<section class="grid" id="products"></section>

<!-- CART -->
<div id="cart" class="sidebar">
<div class="back" onclick="toggleCart()">← Back</div>
<h3>Cart</h3>
<div id="cartItems"></div>
<h4>Total: ₹<span id="total">0</span></h4>
<button onclick="checkout()">Place Order</button>
</div>

<!-- WISHLIST -->
<div id="wishlist" class="sidebar">
<div class="back" onclick="toggleWishlist()">← Back</div>
<h3>Wishlist</h3>
<div id="wishlistItems"></div>
</div>

<script>
const PRODUCTS=[
{title:"iPhone 14",cat:"Mobiles",price:79999,old:89999,rating:4.6,img:"https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb"},
{title:"Samsung S23",cat:"Mobiles",price:69999,old:79999,rating:4.5,img:"https://images.unsplash.com/photo-1511707171634-5f897ff02aa9"},
{title:"MacBook Air",cat:"Laptops",price:99999,old:119999,rating:4.7,img:"https://images.unsplash.com/photo-1517336714731-489689fd1ca8"},
{title:"Dell Laptop",cat:"Laptops",price:59999,old:69999,rating:4.3,img:"https://images.unsplash.com/photo-1593642632823-8f785ba67e45"},
{title:"Headphones",cat:"Electronics",price:2999,old:3999,rating:4.4,img:"https://images.unsplash.com/photo-1600185365483-26d7a4cc7519"},
{title:"Nike Shoes",cat:"Fashion",price:4999,old:6999,rating:4.2,img:"https://images.unsplash.com/photo-1542291026-7eec264c27ff"}
];

let cart=[],wishlist=[],currentCat="All";

/* CATEGORIES */
const cats=["All",...new Set(PRODUCTS.map(p=>p.cat))];
const catEl=document.getElementById("categories");

cats.forEach(c=>{
    catEl.innerHTML+=`<div class="cat" onclick="filterCat('${c}')">${c}</div>`;
});

/* FILTER */
function filterCat(c){
    currentCat=c;
    document.querySelectorAll(".cat").forEach(el=>el.classList.remove("active"));
    event.target.classList.add("active");
    render();
}

/* RENDER */
function render(list){
    const el=document.getElementById("products");
    el.innerHTML="";
    let data=list || PRODUCTS;

    if(currentCat!=="All"){
        data=data.filter(p=>p.cat===currentCat);
    }

    data.forEach((p,i)=>{
        const w=wishlist.includes(i);
        el.innerHTML+=`
        <div class="card">
            <img src="${p.img}">
            <div class="title">${p.title}</div>
            <div>
                <span class="rating">${p.rating}</span>
                <i class="fa-solid fa-star" style="color:#facc15"></i>
            </div>
            <div class="price">₹${p.price} <span class="old">₹${p.old}</span></div>
            <div class="actions">
                <button onclick="add(${i})">Add</button>
                <span class="wish ${w?'active':''}" onclick="toggleWish(${i})">
                    <i class="fa-solid fa-heart"></i>
                </span>
            </div>
        </div>`;
    });
}

/* CART */
function add(i){
    cart.push(PRODUCTS[i]);
    updateCart();
}

function updateCart(){
    let total=0;
    const el=document.getElementById("cartItems");
    el.innerHTML="";
    cart.forEach(p=>{
        total+=p.price;
        el.innerHTML+=`<div>${p.title} - ₹${p.price}</div>`;
    });
    document.getElementById("total").textContent=total;
    document.getElementById("cartCount").textContent=cart.length;
}

function toggleCart(){
    document.getElementById("cart").classList.toggle("active");
}

/* WISHLIST */
function toggleWish(i){
    if(wishlist.includes(i)){
        wishlist=wishlist.filter(x=>x!==i);
    } else wishlist.push(i);
    updateWishlist();
    render();
}

function updateWishlist(){
    const el=document.getElementById("wishlistItems");
    el.innerHTML="";
    wishlist.forEach(i=>{
        const p=PRODUCTS[i];
        el.innerHTML+=`<div>${p.title}</div>`;
    });
    document.getElementById("wishCount").textContent=wishlist.length;
}

function toggleWishlist(){
    document.getElementById("wishlist").classList.toggle("active");
}

/* SEARCH */
document.getElementById("search").addEventListener("input",e=>{
    const q=e.target.value.toLowerCase();
    render(PRODUCTS.filter(p=>p.title.toLowerCase().includes(q)));
});

/* CHECKOUT */
function checkout(){
    alert("Order placed successfully!");
    cart=[];
    updateCart();
}

render();
</script>

</body>
</html>
