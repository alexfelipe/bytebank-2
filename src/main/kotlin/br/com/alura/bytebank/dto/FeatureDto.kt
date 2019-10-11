package br.com.alura.bytebank.dto

import br.com.alura.bytebank.model.Feature

class FeatureRequisicao(
        val nome: String,
        val disponivel: Boolean,
        val feature: Feature = Feature(
                nome = nome,
                disponivel = disponivel
        )
)

class FeatureResposta(feature: Feature,
                      val nome: String = feature.nome,
                      val disponivel: Boolean = feature.disponivel)