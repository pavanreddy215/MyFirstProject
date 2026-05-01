<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">

<title>NexusShop Fixed</title>

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">

<!-- Font Awesome (optional fallback) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    margin:0;
    font-family:Roboto;
    background:#f5f7fa;
}

/* HEADER */
header{
    background:linear-gradient(90deg,#ff6a00,#ee0979);
    color:white;
    padding:12px 20px;
    display:flex;
    justify-content:space-between;
}

/* GRID */
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(220px,1fr));
    gap:15px;
    padding:15px;
}

.card{
    background:white;
    padding:10px;
    border-radius:10px;
}

.card img{
    width:100%;
    height:150px;
    object-fit:cover;
}

/* SIDEBAR */
.sidebar{
    position:fixed;
    right:-350px;
    top:0;
    width:350px;
    height:100%;
    background:white;
    transition:0.3s;
    padding:15px;
}

.sidebar.active{ right:0; }

.cart-item{
    display:flex;
    gap:10px;
    margin:10px 0;
}

.cart-item img{
    width:60px;
}

.remove{
    color:red;
    cursor:pointer;
}
</style>
</head>

<body>

<header>
<h2>NexusShop</h2>

<div>
<span onclick="toggleWishlist()">❤️ <span id="wishCount">0</span></span>
<span onclick="toggleCart()">🛒 <span id="cartCount">0</span></span>
</div>
</header>

<section class="grid" id="products"></section>

<!-- CART -->
<div id="cart" class="sidebar">
<div onclick="toggleCart()">⬅ Back</div>
<h3>Cart</h3>
<div id="cartItems"></div>
<h4>Total: ₹<span id="total">0</span></h4>
</div>

<!-- WISHLIST -->
<div id="wishlist" class="sidebar">
<div onclick="toggleWishlist()">⬅ Back</div>
<h3>Wishlist</h3>
<div id="wishlistItems"></div>
</div>

<script>

/* SAFE IMAGE LIST */
const IMAGES = [
"https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
"https://images.unsplash.com/photo-1511707171634-5f897ff02aa9",
"https://images.unsplash.com/photo-1600185365483-26d7a4cc7519",
"https://images.unsplash.com/photo-1542291026-7eec264c27ff"
];

/* PRODUCTS */
const PRODUCTS=[];
for(let i=1;i<=20;i++){
    PRODUCTS.push({
        title:"Product "+i,
        price:1000+i*200,
        rating:(Math.random()*5).toFixed(1),
        img:IMAGES[i % IMAGES.length],
        specs:{
            ram:"8GB",
            storage:"128GB",
            battery:"4000mAh"
        }
    });
}

let cart=[],wishlist=[];

/* RENDER */
function render(){
    const el=document.getElementById("products");
    el.innerHTML="";

    PRODUCTS.forEach((p,i)=>{
        const inWish=wishlist.includes(i);

        el.innerHTML+=`
        <div class="card">
            <img src="${p.img}" onerror="this.src='https://via.placeholder.com/150'">
            <h4>${p.title}</h4>
            <div>${p.rating} ⭐</div>
            <p>₹${p.price}</p>

            <button onclick="add(${i})">Add</button>

            <span onclick="toggleWish(${i})" style="color:${inWish?'red':'black'};cursor:pointer;">
                ❤️
            </span>
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

    cart.forEach((p,index)=>{
        total+=p.price;

        el.innerHTML+=`
        <div class="cart-item">
            <img src="${p.img}" onerror="this.src='https://via.placeholder.com/60'">
            <div>
                ${p.title}<br>
                ₹${p.price}<br>
                RAM: ${p.specs.ram}<br>
                Storage: ${p.specs.storage}<br>
                Battery: ${p.specs.battery}<br>

                <span class="remove" onclick="removeCart(${index})">Remove</span>
            </div>
        </div>`;
    });

    document.getElementById("total").textContent=total;
    document.getElementById("cartCount").textContent=cart.length;
}

function removeCart(i){
    cart.splice(i,1);
    updateCart();
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
        el.innerHTML+=`
        <div class="cart-item">
            <img src="${p.img}">
            <div>
                ${p.title}<br>
                ₹${p.price}<br>
                <span class="remove" onclick="removeWish(${i})">Remove</span>
            </div>
        </div>`;
    });

    document.getElementById("wishCount").textContent=wishlist.length;
}

function removeWish(i){
    wishlist=wishlist.filter(x=>x!==i);
    updateWishlist();
    render();
}

function toggleWishlist(){
    document.getElementById("wishlist").classList.toggle("active");
}

render();

</script>

</body>
</html>
