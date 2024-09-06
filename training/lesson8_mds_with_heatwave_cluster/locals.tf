# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex",
    "VM.Standard.A1.Flex",
    "VM.Optimized3.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
locals {
  is_flexible_shape = contains(local.compute_flexible_shapes, var.bastion_shape)
}