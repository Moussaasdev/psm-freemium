from fastapi import APIRouter, HTTPException
from app.schemas.question import QuestionSchema
from app.services.question_service import get_question_by_id

router = APIRouter()


@router.get("/questions/{language_code}/{question_id}", response_model=QuestionSchema)
def read_question(language_code: str, question_id: int):
    try:
        return get_question_by_id(language_code, question_id)
    except Exception as e:
        raise HTTPException(status_code=404, detail=str(e))
