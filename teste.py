def lambda_handler(event, context):
    """
    Função Lambda para responder a um evento.
    
    Parametros:
    event (dict): Dados do evento que invocou a função.
    context (object): Informações de contexto da execução.
    
    Returns:
    dict: Resposta com uma mensagem.
    """
    return {
        'statusCode': 200,
        'body': 'Hello from Lambda!'
    }
