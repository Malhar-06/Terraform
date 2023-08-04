output first {
   value = "${join("---->",var.names)}"
}


output second {
   value = "${upper(var.names[0])}"
}

