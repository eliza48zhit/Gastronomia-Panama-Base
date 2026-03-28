// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaPanama
 * @dev Registro historico con Likes, Dislikes e Identificador de Base de Sabor (Culantro/Sofrito).
 */
contract GastronomiaPanama {

    struct Plato {
        string nombre;
        string descripcion;
        string baseSabor; // Ej: Culantro y Gallina de Patio, Achiote, Sofrito Criollo
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con el Sancocho de Gallina Duro
        registrarPlato(
            "Sancocho Panameno", 
            "Sopa de gallina de patio con ame y mucho culantro, servida con arroz blanco.",
            "Culantro"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _baseSabor
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            baseSabor: _baseSabor,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory baseSabor,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.baseSabor, p.likes, p.dislikes);
    }
}
