<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Pavan's Store</title>

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">

<style>
body{margin:0;font-family:Roboto;background:#f5f7fa;}

header{
background:linear-gradient(90deg,#ff6a00,#ee0979);
color:white;padding:12px;
display:flex;align-items:center;justify-content:space-between;
}

.marquee{flex:1;margin:0 20px;}

.grid{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(220px,1fr));
gap:15px;padding:15px;
}

.card{
background:white;padding:10px;border-radius:10px;
}

.card img{width:100%;height:150px;object-fit:cover;}

.sidebar{
position:fixed;right:-350px;top:0;width:350px;height:100%;
background:white;transition:0.3s;padding:15px;overflow:auto;
}

.sidebar.active{right:0;}

.cart-item{display:flex;gap:10px;margin:10px 0;}
.cart-item img{width:60px;}

.remove{color:red;cursor:pointer;font-size:12px;}

.spec{font-size:12px;color:gray;}
</style>
</head>

<body>

<header>
<h2>Pavan's Store</h2>

<div class="marquee">
<marquee>Welcome to Pavan's Summer sale flat 20% off on all products</marquee>
</div>

<div>
<span onclick="toggleWishlist()">&#10084; <span id="wishCount">0</span></span>
<span onclick="toggleCart()">&#128722; <span id="cartCount">0</span></span>
</div>
</header>

<section class="grid" id="products"></section>

<!-- CART -->
<div id="cart" class="sidebar">
<div onclick="toggleCart()">&#8592; Back</div>
<h3>Cart</h3>
<div id="cartItems"></div>
<h4>Total: &#8377;<span id="total">0</span></h4>
</div>

<!-- WISHLIST -->
<div id="wishlist" class="sidebar">
<div onclick="toggleWishlist()">&#8592; Back</div>
<h3>Wishlist</h3>
<div id="wishlistItems"></div>
</div>

<script>

/* REAL PRODUCTS */
const PRODUCTS=[
{
title:"iPhone 14 Pro",
price:129999,
img:"https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb",
specs:{brand:"Apple",model:"A2890",ram:"6GB",storage:"128GB",display:"6.1 inch",battery:"3200mAh",warranty:"1 Year"}
},
{
title:"Samsung Galaxy S23",
price:79999,
img:"https://images.unsplash.com/photo-1511707171634-5f897ff02aa9",
specs:{brand:"Samsung",model:"S23",ram:"8GB",storage:"256GB",display:"6.2 inch",battery:"3900mAh",warranty:"1 Year"}
},
{
title:"MacBook Air M2",
price:119999,
img:"https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
specs:{brand:"Apple",model:"M2",ram:"8GB",storage:"512GB",display:"13 inch",battery:"18hrs",warranty:"1 Year"}
},
{
title:"Sony WH-1000XM5",
price:29999,
img:"https://images.unsplash.com/photo-1600185365483-26d7a4cc7519",
specs:{brand:"Sony",model:"XM5",ram:"-",storage:"-",display:"-",battery:"30hrs",warranty:"1 Year"}
},
{
title:"Nike Air Max",
price:8999,
img:"https://images.unsplash.com/photo-1542291026-7eec264c27ff",
specs:{brand:"Nike",model:"AirMax",ram:"-",storage:"-",display:"-",battery:"-",warranty:"6 Months"}
}
];

let cart=[],wishlist=[];

/* RENDER */
function render(){
const el=document.getElementById("products");
el.innerHTML="";

PRODUCTS.forEach((p,i)=>{
const inWish=wishlist.includes(i);

el.innerHTML+=`
<div class="card">
<img src="${p.img}">
<h4>${p.title}</h4>

<div>${(Math.random()*5).toFixed(1)} &#9733;</div>
<p>&#8377;${p.price}</p>

<div class="spec">
${p.specs.ram} | ${p.specs.storage}
</div>

<button onclick="add(${i})">Add</button>

<span onclick="toggleWish(${i})" style="color:${inWish?'red':'black'};cursor:pointer;">
&#10084;
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
<img src="${p.img}">
<div>
<b>${p.title}</b><br>
&#8377;${p.price}<br>

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
}else wishlist.push(i);

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
&#8377;${p.price}<br>

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