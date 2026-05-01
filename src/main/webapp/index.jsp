<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">

<title>NexusShop Pro</title>

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root{
    --primary:#ff6a00;
    --secondary:#ee0979;
    --bg:#f5f7fa;
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
    padding:12px 20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.icons{
    display:flex;
    gap:20px;
    cursor:pointer;
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
    transition:0.2s;
}

.card:hover{
    transform:scale(1.02);
}

.card img{
    width:100%;
    height:150px;
    object-fit:cover;
}

button{
    background:linear-gradient(90deg,var(--primary),var(--secondary));
    border:none;
    color:white;
    padding:5px 10px;
    border-radius:5px;
    cursor:pointer;
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
    overflow:auto;
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
    font-size:12px;
}

.wish i{
    cursor:pointer;
}

.wish.active i{
    color:red;
}

.spec{
    font-size:12px;
    color:gray;
}
</style>
</head>

<body>

<header>
<h2>NexusShop</h2>

<div class="icons">
<div onclick="toggleWishlist()">
<i class="fa-solid fa-heart"></i>
<span id="wishCount">0</span>
</div>

<div onclick="toggleCart()">
<i class="fa-solid fa-cart-shopping"></i>
<span id="cartCount">0</span>
</div>
</div>
</header>

<section class="grid" id="products"></section>

<!-- CART -->
<div id="cart" class="sidebar">
<div onclick="toggleCart()" style="cursor:pointer">
<i class="fa-solid fa-arrow-left"></i> Back
</div>
<h3>Cart</h3>
<div id="cartItems"></div>
<h4>Total: ₹<span id="total">0</span></h4>
</div>

<!-- WISHLIST -->
<div id="wishlist" class="sidebar">
<div onclick="toggleWishlist()">
<i class="fa-solid fa-arrow-left"></i> Back
</div>
<h3>Wishlist</h3>
<div id="wishlistItems"></div>
</div>

<script>

/* PRODUCTS WITH FULL SPECS */
const PRODUCTS=[];

for(let i=1;i<=20;i++){
    PRODUCTS.push({
        title:"Smart Device "+i,
        price:1000 + i*300,
        rating:(Math.random()*5).toFixed(1),
        img:"https://source.unsplash.com/300x300?tech",

        specs:{
            brand:"Nexus",
            model:"NX-"+i,
            ram:(4+(i%4)*2)+" GB",
            storage:(64+(i%3)*64)+" GB",
            display:"6."+((i%5)+1)+" inch",
            battery:(3000+i*100)+" mAh",
            warranty:"1 Year"
        }
    });
}

let cart=[];
let wishlist=[];

/* RENDER PRODUCTS */
function render(){
    const el=document.getElementById("products");
    el.innerHTML="";

    PRODUCTS.forEach((p,i)=>{
        const inWish=wishlist.includes(i);

        el.innerHTML+=`
        <div class="card">
            <img src="${p.img}">
            <h4>${p.title}</h4>

            <div>
                ${p.rating} ⭐
            </div>

            <p>₹${p.price}</p>

            <div class="spec">
                ${p.specs.ram} | ${p.specs.storage}
            </div>

            <button onclick="addToCart(${i})">Add</button>

            <span class="wish ${inWish?'active':''}" onclick="toggleWish(${i})">
                <i class="fa-solid fa-heart"></i>
            </span>
        </div>`;
    });
}

/* CART */
function addToCart(i){
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
            <img src="${p.img}">
            <div>
                <b>${p.title}</b><br>
                ₹${p.price}<br>

                <div class="spec">
                    Brand: ${p.specs.brand}<br>
                    Model: ${p.specs.model}<br>
                    RAM: ${p.specs.ram}<br>
                    Storage: ${p.specs.storage}<br>
                    Display: ${p.specs.display}<br>
                    Battery: ${p.specs.battery}<br>
                    Warranty: ${p.specs.warranty}
                </div>

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
    } else {
        wishlist.push(i);
    }
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
