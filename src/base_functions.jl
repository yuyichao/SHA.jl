# THE SIX LOGICAL FUNCTIONS
#
# Bit shifting and rotation (used by the six SHA-XYZ logical functions:
#
#   NOTE:  The naming of R and S appears backwards here (R is a SHIFT and
#   S is a ROTATION) because the SHA-256/384/512 description document
#   (see http://csrc.nist.gov/cryptval/shs/sha256-384-512.pdf) uses this
#   same "backwards" definition.

# Shift-right (used in SHA-256, SHA-384, and SHA-512):
R(b,x)     = ((x) >> (b))
# 32-bit Rotate-right (used in SHA-256):
S32(b,x)   = (((x) >> (b)) | ((x) << (32 - (b))))
# 64-bit Rotate-right (used in SHA-384 and SHA-512):
S64(b,x)   = (((x) >> (b)) | ((x) << (64 - (b))))

# Two of six logical functions used in SHA-256, SHA-384, and SHA-512:
Ch(x,y,z)  = (((x) & (y)) $ ((~(x)) & (z)))
Maj(x,y,z) = (((x) & (y)) $ ((x) & (z)) $ ((y) & (z)))

# Four of six logical functions used in SHA-256:
Sigma0_256(x) =   (S32(2,  @compat(UInt32(x))) $ S32(13, @compat(UInt32(x))) $ S32(22, @compat(UInt32(x))))
Sigma1_256(x) =   (S32(6,  @compat(UInt32(x))) $ S32(11, @compat(UInt32(x))) $ S32(25, @compat(UInt32(x))))
sigma0_256(x) =   (S32(7,  @compat(UInt32(x))) $ S32(18, @compat(UInt32(x))) $ R(3 ,   @compat(UInt32(x))))
sigma1_256(x) =   (S32(17, @compat(UInt32(x))) $ S32(19, @compat(UInt32(x))) $ R(10,   @compat(UInt32(x))))

# Four of six logical functions used in SHA-384 and SHA-512:
Sigma0_512(x) =   (S64(28, @compat(UInt64(x))) $ S64(34, @compat(UInt64(x))) $ S64(39, @compat(UInt64(x))))
Sigma1_512(x) =   (S64(14, @compat(UInt64(x))) $ S64(18, @compat(UInt64(x))) $ S64(41, @compat(UInt64(x))))
sigma0_512(x) =   (S64( 1, @compat(UInt64(x))) $ S64( 8, @compat(UInt64(x))) $ R( 7,   @compat(UInt64(x))))
sigma1_512(x) =   (S64(19, @compat(UInt64(x))) $ S64(61, @compat(UInt64(x))) $ R( 6,   @compat(UInt64(x))))

# Let's be able to bswap arrays of these types as well
bswap!(x::Vector{UInt32})  = map!(bswap, x)
bswap!(x::Vector{UInt64})  = map!(bswap, x)
bswap!(x::Vector{UInt128}) = map!(bswap, x)
